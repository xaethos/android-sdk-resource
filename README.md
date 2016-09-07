# Android SDK Resource

[Concourse](https://concourse.ci) resource providing Android SDK dependencies.

## Resource type

As a third party resource, this needs to be declared in the pipeline's
`resource_types` section.


## Source Configuration

* `components`: *Required.* An array of strings with the names of components
  required, as they would be given to the `android update sdk` tool.
  `platform-tools` is always implicitely included. e.g.: if you are building
  an APK against SDK 23, and using the Android support library, you might have:

  ```yaml
  components:
    - tools
    - build-tools-23.0.2
    - android-23
    - extra-android-m2repository
  ```

  The order of the components is not important. Duplicates are ignored.


## Behavior

### `check`

No real check is done. The version of the resource is the list of components
that will be provided.

### `in`

Fetches the Android SDK.

> ##### Important note about licenses
> By using this resource, you are automatically accepting the licenses for all
> components specified. Make sure this is acceptable beforehand.

The destination will have the SDK with requested components installed. The
destination directory can be used as the ANDROID_HOME environmental variable
for your task.

Since Concourse caches resource versions, the SDK won't be downloaded again
unless the set of required components changes.

### `out`

This resource does not support this operation. A `put` step in the build plan
will always fail.


## Example pipeline

Below is an example for an android build pipeline. For brevity, I've inline the
configuration for the `assemble` task; normally it would live in a file of its
own.

Observe that I set the `ANDROID_HOME` environmental variable as part of the run
script. The path must be absolute, not relative, or some parts of the build
won't work.

``` yaml
resource_types:
  - name: android-sdk
    type: docker-image
    source: {repository: xaethos/android-sdk-resource}

resources:
  - name: android-sdk-linux
    type: android-sdk
    source:
      components:
        - android-23
        - build-tools-23.0.2
        - extra-android-m2repository

  - name: project-source
    type: git
    source:
      uri: https://github.com/example/android-project.git
      branch: master

jobs:
  - name: assemble-debug
    plan:
      - get: android-sdk-linux
      - get: project-source
      - task: assemble
        config:
          platform: linux
          image_resource:
            type: docker-image
            source:
              repository: xaethos/android-build
              tag: no-sdk
          inputs:
            - name: android-sdk-linux
            - name: project-source
          run:
            path: sh
            args:
              - -euxc
              - >-
                TERM=screen-256color
                ANDROID_HOME="$PWD/android-sdk-linux"
                project-source/gradlew --project-dir=project-source :app:assembleDebug
```
