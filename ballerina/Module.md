## Overview

DocuSign is a digital transaction management platform that enables users to securely sign, send, and manage documents electronically.

The Ballerina DocuSign Click connector integrates with the DocuSign platform, provides APIs to capture user consent with one click for simple agreements such as terms & conditions and privacy policies within Ballerina applications. It supports [DocuSign Click API V2](https://github.com/docusign/OpenAPI-Specifications/blob/master/click.rest.swagger-v2.json).

## Setup guide

To utilize the DocuSign Click connector, you must have access to the DocuSign REST API through a DocuSign account.

### Step 1: Create a DocuSign account

In order to use the DocuSign Click connector, you need to first create the DocuSign credentials for the connector to interact with DocuSign.

- You can [create an account](https://go.docusign.com/o/sandbox/) for free at the [Developer Center](https://developers.docusign.com/).

    ![Create DocuSign account](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-docusign.dsclick/main/ballerina/resources/create-account.png)

### Step 2: Create integration key and secret key

1. **Create an integration key**: Visit the [Apps and Keys](https://admindemo.docusign.com/apps-and-keys) page on DocuSign. Click on `Add App and Integration Key,` provide a name for the app, and click `Create App`. This will generate an `Integration Key`.

    ![Create integration key](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-docusign.dsclick/main/ballerina/resources/app-and-integration-key.png)

2. **Generate a secret key**: Under the `Authentication` section, click on `Add Secret Key`. This will generate a secret Key. Make sure to copy and save both the `Integration Key` and `Secret Key`.

    ![Add secret key](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-docusign.dsclick/main/ballerina/resources/add-secret-key.png)

### Step 3: Generate refresh token

1. **Add a redirect URI**: Click on `Add URI` and enter your redirect URI (e.g., <http://www.example.com/callback>).

    ![Add redirect URI](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-docusign.dsclick/main/ballerina/resources/add-redirect-uri.png)

2. **Generate the encoded key**: The `Encoded Key` is a base64 encoded string of your `Integration key` and `Secret Key` in the format `{IntegrationKey:SecretKey}`. You can generate this in your web browser's console using the `btoa()` function: `btoa('IntegrationKey:SecretKey')`. You can either generate the encoded key from an online base64 encoder.

3. **Get the authorization code**: Visit the following URL in your web browser, replacing `{iKey}` with your Integration Key and `{redirectUri}` with your redirect URI.

    ```url
    https://account-d.docusign.com/oauth/auth?response_type=code&scope=signature%20organization_read%20click.manage&client_id={iKey}&redirect_uri={redirectUri}
    ```

    This will redirect you to your redirect URI with a `code` query parameter. This is your `authorization code`.

4. **Get the refresh token**: Use the following `curl` command to get the refresh token, replacing `{encodedKey}` with your Encoded Key and `{codeFromUrl}` with your `authorization code`.

    ```bash
    curl --location 'https://account-d.docusign.com/oauth/token' \
    --header 'Authorization: Basic {encodedKey}' \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    --data-urlencode 'code={codeFromUrl}' \
    --data-urlencode 'grant_type=authorization_code'
    ```

    The response will contain your refresh token. Use `https://account-d.docusign.com/oauth/token` as the refresh URL.

Remember to replace `{IntegrationKey:SecretKey}`, `{iKey}`, `{redirectUri}`, `{encodedKey}`, and `{codeFromUrl}` with your actual values.

Above is about using the DocuSign Click APIs in the developer mode. If your app is ready to go live, you need to follow the guidelines given [here](https://developers.docusign.com/docs/esign-rest-api/go-live/) to make it work.

## Quickstart

To use the DocuSign Click connector in your Ballerina project, modify the `.bal` file as follows.

### Step 1: Import the module

Import the `ballerinax/docusign.dsclick` module into your Ballerina project.

```ballerina
import ballerinax/docusign.dsclick;
```

### Step 2: Instantiate a new connector

Create a `dsclick:ConnectionConfig` with the obtained OAuth2.0 tokens and initialize the connector with it.

```ballerina
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string refreshUrl = ?;

dsclick:Client docuSignClient = check new({
    auth: {
        clientId,
        clientSecret,
        refreshToken,
        refreshUrl
    }
});
```

### Step 3: Invoke the connector operation

You can now utilize the operations available within the connector.

```ballerina
public function main() returns error? {

    // Prepare the clickwrap request payload
    dsclick:ClickwrapRequest returnPolicyPayload =  {
        clickwrapName: "ReturnPolicy",
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: "base64-encoded-pdf-file",
                fileExtension: "pdf"
            }
        ],
        displaySettings: {
            displayName: "Return Policy",
            consentButtonText: "I Agree",
            downloadable: true,
            format: "modal",
            requireAccept: true,
            documentDisplay: "document",
            sendToEmail: true 
        }
    };

    // Create a new clickwrap
    dsclick:ClickwrapVersionSummaryResponse newClickWrap = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(returnPolicyPayload);
}
```

>**Hint:** To apply a value to the `documentBase64` field, you can either use an online tool designed to convert a PDF file into a base64-encoded string, or you can refer to the provided [example code](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/blob/main/examples/return-policy-agreement/main.bal#L47)

### Step 4: Run the Ballerina application

Use the following command to compile and run the Ballerina program.

```bash
bal run
```

## Examples

The DocuSign Click connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/tree/main/examples).

1. [Managing return policy agreement clickwrap with DocuSign](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/tree/main/examples/return-policy-agreement)
    This example shows how to use DocuSign Click API to to implement a clickwrap agreement for a return policy to ensure customers acknowledge and agree to the terms before making a purchase.

2. [Managing terms and conditions clickwrap with DocuSign](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/tree/main/examples/terms-and-conditions)
    This example shows how to use DocuSign Click API to to implement a clickwrap agreement for a terms and condition application and users can agree them with just one click.
