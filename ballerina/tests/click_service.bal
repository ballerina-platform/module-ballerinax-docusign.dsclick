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

import ballerina/http;

listener http:Listener ep0 = check new http:Listener(9092);

service /clickapi on ep0 {

    # Gets the current version and other information about the Click API.
    #
    # + return - returns can be any of following types
    # anydata (A successful response or an error.)
    # BadRequestAnydata (Error encountered.)
    resource function get service_information() returns anydata {
        ServiceInformation response = {
            buildVersion: "23.4.0.266 (apiclick2023.10.29.266+b6661c114fe2)",
            linkedSites: ["https://demo.docusign.net"],
            serviceVersions: [
                {
                    version:"v1",
                    versionUrl:"https://demo.docusign.net/clickapi/v1"
                }
            ]
        };
        return response;
    }

    # Gets all the clickwraps for an account.
    #
    # + accountId - A GUID that identifies your account. This value is automatically generated by DocuSign for any account you create. Copy the value from the **API Account ID** field in the **API and Keys** page in eSignature Settings. 
    # + from_date - Optional. The earliest date to return agreements from. 
    # + ownerUserId - Optional. The user ID of the owner. 
    # + page_number - Optional. The page number to return. 
    # + shared - parameter description 
    # + status - Optional. The status of the clickwraps to filter by. One of: - `active` - `inactive` 
    # + to_date - Optional. The latest date to return agreements from. 
    # + return - returns can be any of following types
    # anydata (A successful response or an error.)
    # BadRequestAnydata (Error encountered.)
    resource function get v1/accounts/[string accountId]/clickwraps(string? from_date, string? ownerUserId, string? page_number, string? shared, string? status, string? to_date) returns anydata {
        ClickwrapVersionsResponse response = {
            clickwraps: [
                {
                    clickwrapId: "clickwrap1",
                    versionId: "version1",
                    status: "Active"
                },
                {
                    clickwrapId: "clickwrap2",
                    versionId: "version2",
                    status: "Inactive"
                }
            ],
            minimumPagesRemaining: 2,
            page: 1,
            pageSize: 10
        };
        return response;
    }

    # Creates a clickwrap for an account.
    #
    # + accountId - A GUID that identifies your account. This value is automatically generated by DocuSign for any account you create. Copy the value from the **API Account ID** field in the **API and Keys** page in eSignature Settings. 
    # + payload - parameter description 
    # + return - returns can be any of following types
    # anydata (A successful response or an error.)
    # BadRequestAnydata (Error encountered.)
    resource function post v1/accounts/[string accountId]/clickwraps(@http:Payload ClickwrapRequest|xml payload) returns anydata {
        ClickwrapVersionSummaryResponse response = {
            accountId: accountId,
            clickwrapId: "clickwrap123",
            clickwrapName: "ReturnPolicy",
            clickwrapVersionId: "version123",
            lastModifiedBy: "user123",
            ownerUserId: "user456",
            requireReacceptance: true,
            scheduledReacceptance: {},
            status: "active",
            versionId: "version123",
            versionNumber: "1.0.0"
        };
        return response;
    }
    # Deletes clickwraps for an account.
    #
    # + accountId - A GUID that identifies your account. This value is automatically generated by DocuSign for any account you create. Copy the value from the **API Account ID** field in the **API and Keys** page in eSignature Settings. 
    # + clickwrapIds - A comma-separated list of clickwrap IDs to delete. 
    # + return - returns can be any of following types
    # anydata (A successful response or an error.)
    # BadRequestAnydata (Error encountered.)
    resource function delete v1/accounts/[string accountId]/clickwraps(string? clickwrapIds) returns anydata {
        ClickwrapsDeleteResponse response = {
            clickwraps: [
                {
                    clickwrapId: "clickwrap1",
                    clickwrapName: "ReturnPolicy"
                },
                {
                    clickwrapId: "clickwrap2",
                    clickwrapName: "ReturnPolicy"
                }
            ]
        };
        return response;
    }

    # Gets a  single clickwrap object.
    #
    # + accountId - A GUID that identifies your account. This value is automatically generated by DocuSign for any account you create. Copy the value from the **API Account ID** field in the **API and Keys** page in eSignature Settings. 
    # + clickwrapId - The ID of the clickwrap. 
    # + return - returns can be any of following types
    # anydata (A successful response or an error.)
    # BadRequestAnydata (Error encountered.)
    resource function get v1/accounts/[string accountId]/clickwraps/[string clickwrapId]() returns anydata {
        ClickwrapVersionResponse response = {
            accountId: accountId,
            clickwrapId: "clickwrap123",
            clickwrapName: "ReturnPolicy",
            clickwrapVersionId: "version123",
            displaySettings: {
                consentButtonText: "I Agree",
                displayName: "ReturnPolicy",
                downloadable: true,
                format: "modal",
                mustRead: true,
                mustView: true,
                requireAccept: true
            },
            documents: [
                {
                    documentBase64: "documentBase64",
                    documentName: "document123",
                    'order: 1
                },
                {
                    documentBase64: "documentBase64",
                    documentName: "document456",
                    'order: 2
                }
            ],
            lastModifiedBy: "user123",
            ownerUserId: "user456",
            requireReacceptance: true,
            scheduledReacceptance: {},
            status: "active",
            versionId: "version123",
            versionNumber: "1.0.0"
        };
        return response;
    }

    # Updates the user ID of a clickwrap.
    #
    # + accountId - A GUID that identifies your account. This value is automatically generated by DocuSign for any account you create. Copy the value from the **API Account ID** field in the **API and Keys** page in eSignature Settings. 
    # + clickwrapId - The ID of the clickwrap. 
    # + payload - parameter description 
    # + return - returns can be any of following types
    # anydata (A successful response or an error.)
    # BadRequestAnydata (Error encountered.)
    resource function put v1/accounts/[string accountId]/clickwraps/[string clickwrapId](@http:Payload xml|ClickwrapTransferRequest payload) returns anydata {
        return {
            accountId: accountId,
            clickwrapId: "clickwrap123",
            clickwrapName: "ReturnPolicy",
            clickwrapVersionId: "version123",
            lastModifiedBy: "user123",
            ownerUserId: "user456",
            requireReacceptance: true,
            scheduledReacceptance: {},
            status: "active",
            versionId: "version123",
            versionNumber: "1.0.0"
        };
    }
    # Deletes a clickwrap and all of its versions.
    #
    # + accountId - A GUID that identifies your account. This value is automatically generated by DocuSign for any account you create. Copy the value from the **API Account ID** field in the **API and Keys** page in eSignature Settings. 
    # + clickwrapId - The ID of the clickwrap. 
    # + versions - A comma-separated list of versions to delete. 
    # + return - returns can be any of following types
    # anydata (A successful response or an error.)
    # BadRequestAnydata (Error encountered.)
    resource function delete v1/accounts/[string accountId]/clickwraps/[string clickwrapId](string? versions) returns anydata {
        ClickwrapVersionsDeleteResponse payload = {
            clickwrapId: "clickwrap123",
            clickwrapName: "ReturnPolicy",
            versions: [
                {
                    versionId: "version1",
                    status: "deleted"
                },
                {
                    versionId: "version2",
                    status: "deleted"
                }
            ]
        };
        return payload;    
    }

    # Checks if a user has agreed to a clickwrap.
    #
    # + accountId - A GUID that identifies your account. This value is automatically generated by DocuSign for any account you create. Copy the value from the **API Account ID** field in the **API and Keys** page in eSignature Settings. 
    # + clickwrapId - The ID of the clickwrap. 
    # + payload - parameter description 
    # + return - returns can be any of following types
    # anydata (A successful response or an error.)
    # BadRequestAnydata (Error encountered.)
    resource function post v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/agreements(@http:Payload xml|UserAgreementRequest payload) returns anydata {
        return {
            clientUserId: userId,
            accountId: accountId
        };
    }

    # Gets a specific agreement for a specified clickwrap.
    #
    # + accountId - A GUID that identifies your account. This value is automatically generated by DocuSign for any account you create. Copy the value from the **API Account ID** field in the **API and Keys** page in eSignature Settings. 
    # + clickwrapId - The ID of the clickwrap. 
    # + agreementId - The agreement ID. 
    # + return - returns can be any of following types
    # anydata (A successful response or an error.)
    # BadRequestAnydata (Error encountered.)
    resource function get v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/agreements/[string agreementId]() returns anydata {
    }

    # Gets the completed user agreement PDF.
    #
    # + accountId - A GUID that identifies your account. This value is automatically generated by DocuSign for any account you create. Copy the value from the **API Account ID** field in the **API and Keys** page in eSignature Settings. 
    # + clickwrapId - The ID of the clickwrap. 
    # + agreementId - The agreement ID. 
    # + return - returns can be any of following types
    # http:Ok (A successful response or an error.)
    # BadRequestAnydata (Error encountered.)
    resource function get v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/agreements/[string agreementId]/download() returns http:Ok|BadRequestAnydata {
        return http:OK;
    }

    # Get user agreements
    #
    # + accountId - A GUID that identifies your account. This value is automatically generated by DocuSign for any account you create. Copy the value from the **API Account ID** field in the **API and Keys** page in eSignature Settings. 
    # + clickwrapId - The ID of the clickwrap. 
    # + client_user_id - The client ID. 
    # + from_date - Optional. The earliest date to return agreements from. 
    # + page_number - Optional. The page number to return. 
    # + status - Optional. The status of the clickwraps to return. 
    # + to_date - Optional. The latest date to return agreements from. 
    # + return - returns can be any of following types
    # anydata (A successful response or an error.)
    # BadRequestAnydata (Error encountered.)
    resource function get v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/users(string? client_user_id, string? from_date, string? page_number, string? status, string? to_date) returns anydata {
        ClickwrapAgreementsResponse response = {
            page: 1,
            pageSize: 10,
            userAgreements: []
        };
        return response;
    }

    # Creates a new clickwrap version.
    #
    # + accountId - A GUID that identifies your account. This value is automatically generated by DocuSign for any account you create. Copy the value from the **API Account ID** field in the **API and Keys** page in eSignature Settings. 
    # + clickwrapId - The ID of the clickwrap. 
    # + payload - parameter description 
    # + return - returns can be any of following types
    # anydata (A successful response or an error.)
    # BadRequestAnydata (Error encountered.)
    resource function post v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/versions(@http:Payload ClickwrapRequest|xml payload) returns anydata {
    }
    # Deletes the versions of a clickwrap.
    #
    # + accountId - A GUID that identifies your account. This value is automatically generated by DocuSign for any account you create. Copy the value from the **API Account ID** field in the **API and Keys** page in eSignature Settings. 
    # + clickwrapId - The ID of the clickwrap. 
    # + clickwrapVersionIds - A comma-separated list of clickwrap version IDs to delete. 
    # + return - returns can be any of following types
    # anydata (A successful response or an error.)
    # BadRequestAnydata (Error encountered.)
    resource function delete v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/versions(string? clickwrapVersionIds) returns anydata {
        return {
            clickwrapId: "clickwrap123",
            clickwrapName: "ReturnPolicy",
            versions: [
                {
                    versionId: "version1",
                    status: "deleted"
                },
                {
                    versionId: "version2",
                    status: "deleted"
                }
            ]
        };
    }

    # Gets a specific version from a clickwrap.
    #
    # + accountId - A GUID that identifies your account. This value is automatically generated by DocuSign for any account you create. Copy the value from the **API Account ID** field in the **API and Keys** page in eSignature Settings. 
    # + clickwrapId - The ID of the clickwrap. 
    # + versionId - The ID of the version. 
    # + return - returns can be any of following types
    # anydata (A successful response or an error.)
    # BadRequestAnydata (Error encountered.)
    resource function get v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/versions/[string versionId]() returns anydata {
        ClickwrapVersionResponse response = {
            accountId: accountId,
            clickwrapId: "clickwrap123",
            clickwrapName: "ReturnPolicy",
            clickwrapVersionId: "version123",
            displaySettings: {
                consentButtonText: "I Agree",
                displayName: "ReturnPolicy",
                downloadable: true,
                format: "modal",
                mustRead: true,
                mustView: true,
                requireAccept: true
            },
            documents: [
                {
                    documentBase64: "documentBase64",
                    documentName: "document123",
                    'order: 1
                },
                {
                    documentBase64: "documentBase64",
                    documentName: "document456",
                    'order: 2
                }
            ],
            lastModifiedBy: "user123",
            ownerUserId: "user456",
            requireReacceptance: true,
            
            scheduledReacceptance: {},
            status: "active",
            versionId: "version123",
            versionNumber: "1.0.0"
        };
        return response;
    }
    # Updates a specific version of a clickwrap.
    #
    # + accountId - A GUID that identifies your account. This value is automatically generated by DocuSign for any account you create. Copy the value from the **API Account ID** field in the **API and Keys** page in eSignature Settings. 
    # + clickwrapId - The ID of the clickwrap. 
    # + versionId - The ID of the version. 
    # + payload - parameter description 
    # + return - returns can be any of following types
    # anydata (A successful response or an error.)
    # BadRequestAnydata (Error encountered.)
    resource function put v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/versions/[string versionId](@http:Payload ClickwrapRequest payload) returns anydata {
        ClickwrapVersionSummaryResponse response = {
            accountId: accountId,
            clickwrapId: clickwrapId,
            clickwrapName: payload.clickwrapName,
            clickwrapVersionId: "version123",
            lastModifiedBy: "user123",
            ownerUserId: "user456",
            requireReacceptance: true,
            scheduledReacceptance: {},
            status: "active",
            versionId: "version123",
            versionNumber: "1.0.0"
        };
        return response;
    }
    # Deletes a specific version of a clickwrap.
    #
    # + accountId - A GUID that identifies your account. This value is automatically generated by DocuSign for any account you create. Copy the value from the **API Account ID** field in the **API and Keys** page in eSignature Settings. 
    # + clickwrapId - The ID of the clickwrap. 
    # + versionId - The ID of the version. 
    # + return - returns can be any of following types
    # anydata (A successful response or an error.)
    # BadRequestAnydata (Error encountered.)
    resource function delete v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/versions/[string versionId]() returns anydata {
        ClickwrapVersionDeleteResponse response = {
            clickwrapVersionId: "version123",
            lastModifiedBy: "user123",
            ownerUserId: "user456",
            requireReacceptance: true,
            scheduledReacceptance: {},
            status: "deleted",
            versionId: "version123",
            versionNumber: "1.0.0"
        };
        return response;
    }
    # Gets the agreement responses for a clickwrap version.
    #
    # + accountId - A GUID that identifies your account. This value is automatically generated by DocuSign for any account you create. Copy the value from the **API Account ID** field in the **API and Keys** page in eSignature Settings. 
    # + clickwrapId - The ID of the clickwrap. 
    # + versionId - The ID of the version. 
    # + client_user_id - parameter description 
    # + from_date - Optional. The earliest date to return agreements from. 
    # + page_number - Optional. The page number to return. 
    # + status - Clickwrap status. Possible values: - `active` - `inactive` - `deleted` 
    # + to_date - Optional. The latest date to return agreements from. 
    # + return - returns can be any of following types
    # anydata (A successful response or an error.)
    # BadRequestAnydata (Error encountered.)
    resource function get v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/versions/[string versionId]/users(string? client_user_id, string? from_date, string? page_number, string? status, string? to_date) returns anydata {
        ClickwrapAgreementsResponse response = {
            page: 1,
            pageSize: 10,
            userAgreements: []
        };
        return response;
    }
}
