## Examples

The DocuSign Click connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-docusign.click/tree/main/examples).

1. [Return Policy Agreement with DocuSign Click](https://github.com/ballerina-platform/module-ballerinax-docusign.click/tree/main/examples/return-policy-agreement)
    This example shows how to use DocuSign Click APIs to to implement a clickwrap agreement for a return policy to ensure customers acknowledge and agree to the terms before making a purchase.

## Prerequisites

1. Follow the [instructions](https://github.com/ballerina-platform/module-ballerinax-docusign.click#set-up-guide) to set up the DocuSign Click API.

2. For each example, create a `Config.toml` file with your OAuth2 tokens, client ID, and client secret. Here's an example of how your `Config.toml` file should look:

    ```toml
    token = <Access Token>
    accountId = <Account ID>
    ```

## Running an Example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the Examples with the Local Module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
