load('ext://restart_process', 'docker_build_with_restart')

local_resource(
  'example-go-compile',
  'CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o build/tilt-example-go ./',
  deps=['./main.go'])

docker_build_with_restart(
  'example-go-image',
  '.',
  entrypoint='/app/build/tilt-example-go',
  dockerfile='Dockerfile',
  target='live-update',
  only=[
    './build',
  ],
  live_update=[
    sync('./build', '/app/build'),
  ],
)

k8s_yaml('deployment.yaml')
k8s_resource('example-go', port_forwards=8000)
