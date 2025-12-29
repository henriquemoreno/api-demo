var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.Use(async (context, next) =>
{
    var slot = Environment.GetEnvironmentVariable("DEPLOY_SLOT") ?? "unknown";

    context.Response.OnStarting(() =>
    {
        context.Response.Headers["X-Deploy-Slot"] = slot;
        return Task.CompletedTask;
    });

    await next();
});

app.Logger.LogInformation("API started | Slot: {Slot}", 
    Environment.GetEnvironmentVariable("DEPLOY_SLOT") ?? "unknown");

app.MapGet("/health", () => Results.Ok(new
{
    status = "healthy",
    service = "ApiDemo",
    slot = Environment.GetEnvironmentVariable("DEPLOY_SLOT") ?? "unknown"
}));

var appStartTime = DateTime.UtcNow;

app.MapGet("/ready", () =>
{
    // Simula warmup (ex: conexões, cache, migrations etc.)
    var uptime = DateTime.UtcNow - appStartTime;

    if (uptime.TotalSeconds < 5)
    {
        return Results.StatusCode(503);
    }

    return Results.Ok(new
    {
        status = "ready",
        service = "ApiDemo"
    });
});

var summaries = new[]
{
    "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
};

app.MapGet("/weatherforecast", () =>
{
    var forecast =  Enumerable.Range(1, 5).Select(index =>
        new WeatherForecast
        (
            DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
            Random.Shared.Next(-20, 55),
            summaries[Random.Shared.Next(summaries.Length)]
        ))
        .ToArray();
    return forecast;
})
.WithName("GetWeatherForecast")
.WithOpenApi();

app.MapGet("/hello", () =>
{
    return "Hello World!";
});

app.MapGet("/teste", () =>
{
    return "Retorno endpoint de teste.";
});

app.MapGet("/no", () =>
{
    return "Big No.";
});

app.MapGet("/deploy-final", () => "CI/CD com runner self-hosted funcionando 🚀");

app.MapGet("/auto", () => "deploy automatico funcionando 🚀");

app.MapGet("/produtos", () =>
{
    var produtos = new List<string>
    {
       "Computador",
       "Geladeira",
       "TV",
       "Monitor" 
    };

    return produtos;
});

app.MapGet("/compose", () =>
{
    return "Compose configurado - COM VERSIONAMENTO";
});

app.Run();

record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}
