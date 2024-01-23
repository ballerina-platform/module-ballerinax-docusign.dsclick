// Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com) All Rights Reserved.
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

configurable string accessToken = ?;
configurable string userId = ?;
configurable string accountId = ?;

@test:BeforeSuite
function initializeClientsForCalendarServer () returns error? {
    if isTestOnLiveServer {
        docuSignClient = check new(
            {
                timeout: 10000,
                auth: {
                    token: os:getEnv("ACCESS_TOKEN")
                }
            },
            serviceUrl = "https://demo.docusign.net/clickapi/"
        );
    } else {
        docuSignClient = check new(
            {
                timeout: 10000,
                auth: {
                    token: accessToken
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
    _ = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[<string>response.clickwrapId].delete();
}

// @test:Config {
//     groups: ["account"]
// }
// function testUpdateClickWrap() returns error? {
//     string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.pdf"));
//     string clickwrapName = "ReturnPolicy";
//     ClickwrapRequest payload =  {
//         clickwrapName: clickwrapName,
//         documents: [
//             {
//                 documentName: "Test Doc",
//                 documentBase64: base64Encoded,
//                 fileExtension: "pdf"
//             }
//         ],
//         displaySettings: {
//             displayName: "Return Policy",
//             consentButtonText: "I Agree",
//             downloadable: true,
//             format: "modal",
//             requireAccept: true,
//             documentDisplay: "document",
//             sendToEmail: true 
//         }
//     };
//     ClickwrapVersionSummaryResponse response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
//     ClickwrapVersionSummaryResponse updatedResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[<string>response.clickwrapId].put({
//         transferFromUserId: response.ownerUserId,
//         transferToUserId: ""
//     });
//     test:assertEquals(updatedResponse.accountId, accountId);
// }

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
    ClickwrapVersionsDeleteResponse deleteResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[<string>response.clickwrapId].delete();
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
    ClickwrapVersionSummaryResponse getResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[<string>response.clickwrapId]();
    test:assertEquals(getResponse.accountId, accountId);
    _ = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[<string>response.clickwrapId].delete();
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
    _ = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[<string>response.clickwrapId].delete();
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
    ClickwrapVersionDeleteResponse deleteResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[<string>response.clickwrapId]/versions/[<string>response.versionNumber].delete();
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
    ClickwrapAgreementsResponse agreementResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[<string>response.clickwrapId]/versions/[<string>response.versionNumber]/users();
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
    ClickwrapVersionResponse getResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[<string>response.clickwrapId]/versions/[<string>response.versionNumber]();
    test:assertEquals(getResponse.accountId, accountId);
    _ = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[<string>response.clickwrapId].delete();
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
    ClickwrapVersionSummaryResponse updateRes = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[<string>response.clickwrapId]/versions/[<string>response.versionNumber].put({
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
        UserAgreementResponse agreementResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[<string>response.clickwrapId]/agreements.post({
            clientUserId: userId
        });

        test:assertEquals(agreementResponse.accountId, accountId);
    }
}
