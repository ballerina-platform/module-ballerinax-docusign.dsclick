# Managing terms and conditions clickwrap with DocuSign

This guide demonstrates how to integrate the DocuSign Click API into a Ballerina application to manage clickwraps for terms and conditions. The example covers creating, updating, retrieving versions, fetching user agreements, and deleting clickwraps.

## Step 1: Import DocuSign connector

Import the `ballerinax/docusign.dsclick` module into your Ballerina project.

```ballerina
import ballerinax/docusign.dsclick;
```

## Step 2: Instantiate a new DocuSign client

Define configurable parameters such as `clientId`, `clientSecret`, `refreshToken`, `refreshUrl`, `accountId` and `userId` to set up the DocuSign connection. Initialize the DocuSign client with the specified service URL and connection configuration. Define the clickwrap payload, including document details and display settings.

```ballerina
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string refreshUrl = ?;
configurable string accountId = ?;
configurable string userId = ?;

public function main() returns error? {
    dsclick:Client docuSignClient = check new(
        {
            auth: {
                clientId,
                clientSecret,
                refreshToken,
                refreshUrl
            }
        },
        serviceUrl = "https://demo.docusign.net/clickapi/"
    );
}
```

## Step 3: Create new DocuSign clickwrap for terms and conditions

Create a new clickwrap for terms and conditions.

```ballerina
dsclick:Client docuSignClient = check new(serviceUrl = "https://demo.docusign.net/clickapi", config = { auth: {
    token: accessToken
}});

dsclick:ClickwrapRequest termsPayload =  {
    clickwrapName: "TermsAndConditions",
    documents: [
        {
            documentName: "Terms Document",
            documentBase64: array:toBase64(check io:fileReadBytes("./resources/Terms.pdf")),
            fileExtension: "pdf"
        }
    ],
    displaySettings: {
        displayName: "Terms and Conditions",
        consentButtonText: "I Agree",
        downloadable: true,
        format: "modal",
        requireAccept: true,
        documentDisplay: "document",
        sendToEmail: true 
    }
};

dsclick:ClickwrapVersionSummaryResponse newClickWrap = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(termsPayload);
io:println(newClickWrap);
```

## Step 4: Retrieve clickwrap version

Retrieve information about a specific clickwrap version.

```ballerina
string? clickwrapId = newClickWrap.clickwrapId;
if clickwrapId is () {
    return error("Clickwrap ID is empty");
}
string? versionId = newClickWrap.versionId;
if versionId is () {
    return error("Version ID is empty");
}

dsclick:ClickwrapVersionSummaryResponse versionResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId];
io:println(versionResponse);
```

## Step 6: Update the clickwrap

Update the existing clickwrap with new information.

```ballerina
termsPayload.displaySettings.displayName = "Updated Terms and Conditions";
dsclick:ClickwrapVersionSummaryResponse updateClickWrap = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionId].put(termsPayload);
io:println(updateClickWrap);
```

## Step 7: Get user agreements

Retrieve user agreements for a specific clickwrap version.

```ballerina
dsclick:ClickwrapAgreementsResponse response = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionId]/users();
io:println(response);
```

## Step 8: Delete the clickwrap

Delete the clickwrap for terms and conditions.

```ballerina
dsclick:ClickwrapVersionsDeleteResponse deleteResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId].delete();
io:println(deleteResponse);
```
