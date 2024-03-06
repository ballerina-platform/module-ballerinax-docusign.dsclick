// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com) All Rights Reserved.
//
// WSO2 LLC. licenses this file to you under the Apache License,
// versionId 2.0 (the "License"); you may not use this file except
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

import ballerina/test;
import ballerina/os;
import ballerina/lang.array;
import ballerina/io;

Client docuSignClient = test:mock(Client);

configurable boolean isTestOnLiveServer = os:getEnv("IS_TEST_ON_LIVE_SERVER") == "true";

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string refreshUrl = ?;
configurable string accountId = ?;
configurable string userId = ?;

@test:BeforeSuite
function initializeClientsForDocuSignServer() returns error? {
    if isTestOnLiveServer {
        docuSignClient = check new(
            {
                timeout: 10000,
                auth: {
                    clientId: os:getEnv("CLIENT_ID"),
                    clientSecret: os:getEnv("CLIENT_SECRET"),
                    refreshToken: os:getEnv("REFRESH_TOKEN"),
                    refreshUrl: os:getEnv("REFRESH_URL")
                }
            },
            serviceUrl = "https://demo.docusign.net/clickapi/"
        );
    } else {
        docuSignClient = check new(
            {
                timeout: 10000,
                auth: {
                    clientId,
                    clientSecret,
                    refreshToken,
                    refreshUrl
                }
            },
            serviceUrl = "http://localhost:9092/clickapi"
        );
    }
}

@test:Config {
    groups: ["account"]
}
function testServiceInfo() returns error? {
    ServiceInformation expectedPayload = {
        buildVersion: "23.4.0.266 (apiclick2023.10.29.266+b6661c114fe2)",
        linkedSites: ["https://demo.docusign.net"],
        serviceVersions: [
            {
                version:"v1",
                versionUrl:"https://demo.docusign.net/clickapi/v1"
            }
        ]
    };
    ServiceInformation response = check docuSignClient->/service_information;
    test:assertEquals(response, expectedPayload);
}

@test:Config {
    groups: ["account"]
}
function testCreateClickWrap() returns error? {
    string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.pdf"));
    string clickwrapName = "ReturnPolicy";
    ClickwrapRequest payload =  {
        clickwrapName: clickwrapName,
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: base64Encoded,
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
    ClickwrapVersionSummaryResponse response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
    test:assertEquals(response.clickwrapName, clickwrapName);
    string? clickwrapId = response.clickwrapId;
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    _ = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId].delete();
}

@test:Config {
    groups: ["account"]
}
function testDeleteClickWrap() returns error? {
    string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.pdf"));
    string clickwrapName = "ReturnPolicy";
    ClickwrapRequest payload =  {
        clickwrapName: clickwrapName,
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: base64Encoded,
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
    ClickwrapVersionSummaryResponse response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
    test:assertEquals(response.clickwrapName, clickwrapName);
    string? clickwrapId = response.clickwrapId;
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    ClickwrapVersionsDeleteResponse deleteResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId].delete();
    test:assertEquals(deleteResponse.clickwrapId, response.clickwrapId);
}

@test:Config {}
function testGetSingleClickwrap() returns error? {
    string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.pdf"));
    string clickwrapName = "ReturnPolicy";
    ClickwrapRequest payload =  {
        clickwrapName: clickwrapName,
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: base64Encoded,
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
    ClickwrapVersionSummaryResponse response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
    string? clickwrapId = response.clickwrapId;
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    ClickwrapVersionSummaryResponse getResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]();
    test:assertEquals(getResponse.accountId, accountId);
    _ = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId].delete();
}

@test:Config {}
function testGetAllClickwraps() returns error? {
    string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.pdf"));
    string clickwrapName = "ReturnPolicy";
    ClickwrapRequest payload =  {
        clickwrapName: clickwrapName,
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: base64Encoded,
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
    ClickwrapVersionSummaryResponse response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
    ClickwrapVersionsResponse allClickwraps = check docuSignClient->/v1/accounts/[accountId]/clickwraps();
    test:assertNotEquals(allClickwraps.clickwraps, ());
    string? clickwrapId = response.clickwrapId;
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    _ = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId].delete();
}

@test:Config {
    groups: ["clickwrap"]
}
function testDeleteClickwrapVersionByNumber() returns error? {
    string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.pdf"));
    string clickwrapName = "ReturnPolicy";
    ClickwrapRequest payload =  {
        clickwrapName: clickwrapName,
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: base64Encoded,
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
    ClickwrapVersionSummaryResponse response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
    string? clickwrapId = response.clickwrapId;
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    string? versionNumber = response.versionNumber;
    if versionNumber is () {
        return error("Version number is not available");
    }
    ClickwrapVersionDeleteResponse deleteResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionNumber].delete();
    test:assertEquals(deleteResponse.versionNumber, response.versionNumber);
}

@test:Config {
    groups: ["clickwrap"]
}
function testGetClickwrapAgreementsByVersionNumber() returns error? {
    string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.pdf"));
    string clickwrapName = "ReturnPolicy";
    ClickwrapRequest payload =  {
        clickwrapName: clickwrapName,
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: base64Encoded,
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
    ClickwrapVersionSummaryResponse response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
    string? clickwrapId = response.clickwrapId;
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    string? versionNumber = response.versionNumber;
    if versionNumber is () {
        return error("Version number is not available");
    }
    ClickwrapAgreementsResponse agreementResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionNumber]/users();
    test:assertEquals(agreementResponse.userAgreements, []);
}

@test:Config {
    groups: ["clickwrap"]
}
function testGetClickwrapVersionByNumber() returns error? {
    string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.pdf"));
    string clickwrapName = "ReturnPolicy";
    ClickwrapRequest payload =  {
        clickwrapName: clickwrapName,
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: base64Encoded,
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
    ClickwrapVersionSummaryResponse response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
    string? clickwrapId = response.clickwrapId;
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    string? versionNumber = response.versionNumber;
    if versionNumber is () {
        return error("Version number is not available");
    }
    ClickwrapVersionResponse getResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionNumber]();
    test:assertEquals(getResponse.accountId, accountId);
    _ = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId].delete();
}

@test:Config {
    groups: ["clickwrap"]
}
function testUpdateClickwrapVersionByNumber() returns error? {
    string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.pdf"));
    string clickwrapName = "ReturnPolicy";
    ClickwrapRequest payload =  {
        clickwrapName: clickwrapName,
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: base64Encoded,
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
    string clickwrapUpdatedName = "Updated Clickwrap";
    ClickwrapVersionSummaryResponse response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
    string? clickwrapId = response.clickwrapId;
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    string? versionNumber = response.versionNumber;
    if versionNumber is () {
        return error("Version number is not available");
    }
    ClickwrapVersionSummaryResponse updateRes = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionNumber].put({
        clickwrapName: clickwrapUpdatedName
    });
    test:assertEquals(updateRes.clickwrapName, clickwrapUpdatedName);
}

@test:Config {}
function testPostUserAgreement() returns error? {
   string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.pdf"));
    string clickwrapName = "ReturnPolicy";
    ClickwrapRequest payload =  {
        clickwrapName: clickwrapName,
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: base64Encoded,
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
        },
        status: "active"
    };
    ClickwrapVersionSummaryResponse response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
    if response.status == "active" {
        string? clickwrapId = response.clickwrapId;
        if clickwrapId is () {
            return error("Clickwrap Id is not available");
        }
        UserAgreementResponse agreementResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/agreements.post({
            clientUserId: userId
        });

        test:assertEquals(agreementResponse.accountId, accountId);
    }
}
