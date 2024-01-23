// Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com) All Rights Reserved.
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

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
    click:ClickwrapRequest returnPolicyPayload =  {
        clickwrapName: "ReturnPolicy",
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: array:toBase64(check io:fileReadBytes("./resources/README.pdf")),
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

    click:ClickwrapVersionSummaryResponse newClickWrap = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(returnPolicyPayload);

    string clickwrapId = <string>newClickWrap.clickwrapId;
    string versionId = <string>newClickWrap.versionId;
    click:ClickwrapVersionSummaryResponse versionResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId];
    io:println(versionResponse);

    returnPolicyPayload.displaySettings.displayName = "Return Policy Updated";
    click:ClickwrapVersionSummaryResponse updateClickWrap = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionId].put(returnPolicyPayload);
    io:println(updateClickWrap);

    click:ClickwrapAgreementsResponse response = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionId]/users();
    io:println(response);

    click:ClickwrapVersionsDeleteResponse deleteResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId].delete();
    io:println(deleteResponse);
}
