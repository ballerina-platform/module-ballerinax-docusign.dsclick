// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com) All Rights Reserved.
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
import ballerinax/docusign.dsclick;
import ballerina/lang.array;
import ballerina/os;

configurable string clientId = os:getEnv("CLIENT_ID");
configurable string clientSecret = os:getEnv("CLIENT_SECRET");
configurable string refreshToken = os:getEnv("REFRESH_TOKEN");
configurable string refreshUrl = os:getEnv("REFRESH_URL");
configurable string accountId = os:getEnv("ACCOUNT_ID");
configurable string userId = os:getEnv("USER_ID");
configurable string serviceUrl = os:getEnv("SERVICE_URL");

public function main() returns error? {
    dsclick:Client docuSignClient = check new(
        serviceUrl,
        {
            auth: {
                clientId,
                clientSecret,
                refreshToken,
                refreshUrl
            }
        }
    );

    dsclick:ClickwrapRequest returnPolicyPayload =  {
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

    dsclick:ClickwrapVersionSummaryResponse newClickWrap = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(returnPolicyPayload);

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

    returnPolicyPayload.displaySettings.displayName = "Return Policy Updated";
    dsclick:ClickwrapVersionSummaryResponse updateClickWrap = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionId].put(returnPolicyPayload);
    io:println(updateClickWrap);

    dsclick:ClickwrapAgreementsResponse response = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionId]/users();
    io:println(response);

    dsclick:ClickwrapVersionsDeleteResponse deleteResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId].delete();
    io:println(deleteResponse);
}
