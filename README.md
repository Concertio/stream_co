# stream_co

stream benchmark compiler flag mining Continuous Optimization Example

## setup: build studio image

1. licensing: there are two ways to handle it:

    1.1. add license in the Dockerfile as value to OPTIMIZER_LICENSE_KEY environment variable

    1.2. just export OPTIMIZER_LICENSE_KEY=<your_license_key> in your build environment (be it command line or CI tool)

2. run:

    ```shell
    ./build_image.sh
    ```

## continuous optimization

In this demo, the workload script will expect the gcc flags to be found in `flags.make` file.

In real world applcations, you will want to first of all set your existing flags as Default options in optimizer-studio `knobs.yaml` file,

and only then proceed to running optimizer.

Here is a pseudo example for adding your existing flags as baseline options to optimizer-studio:

```yaml
    domain:
      common:
        knobs:
          base_opt:
            description: base compiler option flag
            default: -Ofast
            options:
            - -O3
            - -O0
            - -O1
            - -O2
            - -Os
            - -Ofast
            - -Og
            - ' '
          bool__fexcess_precision:
            description: 'compiler flag: -fexcess-precision'
            default: -fexcess-precision=fast
            options:
            - -fexcess-precision=fast
            - -fexcess-precision=standard
            - ' '
```

## running the example

run:

```shell
    ./run.sh
```

It will run optimizer-studio, with the given `workload.sh` and `knobs.yaml` file.

the build workload script, is expected to read the compilation flags from optimizer through environment variable array,

store it in `flags.make` file,

and run the build command to compile stream.c.

It will then execute the stream tool that has just been compiled, and measure the performance through the output.

In your environment, you will want to change that build line with your own build command and make file.

You are only required to update your build scripts to read the flags from `flags.make` that the workload script produces in each iteration.

Good Luck Optimizing!

## CI Tool Pipeline integration

TODO: add Jenkins pipeline `JenkinsFile` and a `docker-compose.yaml` files to this repo, to orchestrate a full demo Jenkins CO pipeline example.
