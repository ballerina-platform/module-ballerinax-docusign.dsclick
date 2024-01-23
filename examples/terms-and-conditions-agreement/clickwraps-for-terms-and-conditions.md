# Managing Terms and Conditions Clickwrap with DocuSign

This guide demonstrates how to integrate the DocuSign Click API into a Ballerina application to manage clickwraps for terms and conditions. The example covers creating, updating, retrieving versions, fetching user agreements, and deleting clickwraps.

## Step 1: Import DocuSign Connector

Import the `ballerinax/docusign.dsclick` module into your Ballerina project.

```ballerina
import ballerinax/docusign.dsclick;
```

## Step 2: Set Up DocuSign Connection

Define configurable parameters such as `accessToken` and `accountId` to set up the DocuSign connection.

```ballerina
configurable string accessToken = ?;
configurable string accountId = ?;
```

## Step 3: Create DocuSign Clickwrap for Terms and Conditions

Initialize the DocuSign client with the specified service URL and connection configuration. Define the clickwrap payload, including document details and display settings.

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
```

## Step 4: Create new Clickwrap

Create a new clickwrap for terms and conditions by posting the clickwrap payload.

```ballerina
dsclick:ClickwrapVersionSummaryResponse newClickWrap = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(termsPayload);
io:println(newClickWrap);
```

## Step 5: Get Clickwrap Version

Retrieve information about a specific clickwrap version.

```ballerina
string clickwrapId = <string>newClickWrap.clickwrapId;
string versionId = <string>newClickWrap.versionId;
dsclick:ClickwrapVersionSummaryResponse versionResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId];
io:println(versionResponse);
```

## Step 6: Update Clickwrap

Update the existing clickwrap with new information.

```ballerina
termsPayload.displaySettings.displayName = "Updated Terms and Conditions";
dsclick:ClickwrapVersionSummaryResponse updateClickWrap = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionId].put(termsPayload);
io:println(updateClickWrap);
```

## Step 7: Get User Agreements

Retrieve user agreements for a specific clickwrap version.

```ballerina
dsclick:ClickwrapAgreementsResponse response = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionId]/users();
io:println(response);
```

## Step 8: Delete Clickwrap

Delete the clickwrap for terms and conditions.

```ballerina
dsclick:ClickwrapVersionsDeleteResponse deleteResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId].delete();
io:println(deleteResponse);
```
