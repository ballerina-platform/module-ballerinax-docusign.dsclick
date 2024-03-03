## Examples

The DocuSign Click connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/tree/main/examples).

1. [Managing return policy agreement clickwrap with DocuSign](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/tree/main/examples/return-policy-agreement)
    This example shows how to use DocuSign Click API to to implement a clickwrap agreement for a return policy to ensure customers acknowledge and agree to the terms before making a purchase.

2. [Managing terms and conditions clickwrap with DocuSign](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/tree/main/examples/terms-and-conditions)
    This example shows how to use DocuSign Click API to to implement a clickwrap agreement for a terms and condition application and users can agree them with just one click.

## Prerequisites

1. Follow the [instructions](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick#set-up-guide) to set up the DocuSign Click API.

2. For each example, create a `Config.toml` file with your OAuth2 tokens, client ID, and client secret. Here's an example of how your `Config.toml` file should look:

    ```toml
    clientId="<Client ID>"
    clientSecret="<Client Secret>"
    refreshToken="<Refresh Token>"
    refreshUrl="<Refresh URL>"
    accountId = "<Account ID>"
    ```

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

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
