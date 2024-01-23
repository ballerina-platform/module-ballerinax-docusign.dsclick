import ballerina/io;
import ballerinax/docusign.dsclick as click;
import ballerina/lang.array;

configurable string accessToken = ?;
configurable string accountId = ?;

public function main() returns error? {
    click:Client docuSignClient = check new(serviceUrl = "https://demo.docusign.net/clickapi", config = { auth: {
        token: accessToken
    }});

    io:println(docuSignClient);
    string base64Encoded = array:toBase64(check io:fileReadBytes("./resources/Terms.pdf"));
    click:ClickwrapRequest termsPayload =  {
        clickwrapName: "TermsAndConditions",
        documents: [
            {
                documentName: "Terms Document",
                documentBase64: base64Encoded,
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

    click:ClickwrapVersionSummaryResponse newClickWrap = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(termsPayload);
    io:println(newClickWrap);

    string clickwrapId = <string>newClickWrap.clickwrapId;
    string versionId = <string>newClickWrap.versionId;
    click:ClickwrapVersionSummaryResponse versionResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId];
    io:println(versionResponse);

    termsPayload.displaySettings.displayName = "Updated Terms and Conditions";
    click:ClickwrapVersionSummaryResponse updateClickWrap = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionId].put(termsPayload);
    io:println(updateClickWrap);

    click:ClickwrapAgreementsResponse response = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionId]/users();
    io:println(response);

    click:ClickwrapVersionsDeleteResponse deleteResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId].delete();
    io:println(deleteResponse);
}
