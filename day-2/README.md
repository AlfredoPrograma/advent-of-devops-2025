# Day 2: Fix the Slow Docker Build

## Description
You've inherited a Dockerfile from a previous developer, and it's painfully slow. Every code change triggers a full rebuild that takes several minutes. Your team is frustrated with the slow feedback loop during development.

### Task
Rewrite the Dockerfile so the build time is reduced by at least 50%.

### Requirements:

- [x] Maintain the same functionality
- [x] Reduce build time by minimum 50%
- [x] Optimize layer caching
- [x] Follow Docker best practices

### Target
- Build Time Reduction: 50% or more
- Cache Hit Rate: Maximize layer reuse
- First Build: May be similar, but rebuilds should be fast

## Verification

### Building image using slow Dockerfile
1. Build docker image using slow Dockerfile and measure time
```sh
time docker build -t advent-day2:slow --file Dockerfile.slow .
# docker build -t advent-day2:slow --file ./Dockerfile.slow .  0.18s user 0.10s system 1% cpu 17.770 total 
# (~17.7 seconds to build)
``` 

2. Make an small change in `main.go` file; something like change the `message` value of the json response and rebuild again measuring time
```go
// ... previous code
	r.GET("/ping", func(ctx *gin.Context) {
		ctx.JSON(http.StatusOK, gin.H{
			"message": "example", // change message field value from "hello" to "example"
		})
	})
```
```sh
time docker build -t advent-day2:slow --file Dockerfile.slow .
# docker build -t advent-day2:slow --file ./Dockerfile.slow .  0.18s user 0.09s system 1% cpu 18.685 total
# (~18.6 seconds to build)
```

### Building image using optimized Dockerfile
1. Build docker image using optimized Dockerfile and measure time
```sh
time docker build -t advent-day2:fast .
# docker build -t advent-day2:fast .  0.14s user 0.07s system 19% cpu 1.097 total
# (~1 second to build)
```

2. Make an small change in `main.go` file; something like change the `message` value of the json response and rebuild again measuring time
```go
// ... previous code
	r.GET("/ping", func(ctx *gin.Context) {
		ctx.JSON(http.StatusOK, gin.H{
			"message": "fast", // change message field value from "hello" to "fast"
		})
	})
```
```sh
time docker build -t advent-day2:fast  . 
# docker build -t advent-day2:fast .  0.16s user 0.09s system 15% cpu 1.588 total
# (~1.5 seconds to build)
```

## What optimizations were made?

- `go.mod` and `go.sum` files were copied in their own layer; and dependencies were installed using `go mod download` after that layer. It means that those layers will be cached until `go.mod` or `go.sum` files change (when some dependency is added or removed). So next builds, will reuse downloaded dependencies.
- `/root/.cache/go-build` was mount as `cache` to also manage golang binary building caching. This cache volume is managed automatically by Docker on building stage and does not ship extra size or garbage to final running container.
- Used multi-staged build to separate binary building from application running, making sure to ship low size container based on Alpine. 