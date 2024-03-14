# Managing terms and conditions clickwrap with DocuSign

This guide demonstrates how to integrate the DocuSign Click API into a Ballerina application to manage clickwraps for terms and conditions. The example covers creating, updating, retrieving versions, fetching user agreements, and deleting clickwraps.

## Prerequisites

Follow the guidelines in the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick?tab=readme-ov-file#setup-guide) to get access to DocuSign APIs.

### Configuration

Configure DocuSign API credentials in Config.toml in the example directory.

```toml
accountId = "<ACCOUNT_ID>"
userId = "<USER_ID>"
clientId = "<CLIENT_ID>"
clientSecret = "<CLIENT_SECRET>"
refreshToken = "<REFRESH_TOKEN>"
refreshUrl = "<REFRESH_URL>"
```

## Run the example

Execute the following command to run the example.

```ballerina
bal run
```
