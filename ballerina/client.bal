// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
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

# DocuSign Click lets you capture consent to standard agreement terms with a single click: terms and conditions, terms of service, terms of use, privacy policies, and more. The Click API lets you include this customizable clickwrap solution in your DocuSign integrations.
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config =  {}, string serviceUrl = "https://www.docusign.net/clickapi") returns error? {
        http:ClientConfiguration httpClientConfig = {httpVersion: config.httpVersion, http1Settings: config.http1Settings, http2Settings: config.http2Settings, timeout: config.timeout, forwarded: config.forwarded, followRedirects: config.followRedirects, poolConfig: config.poolConfig, cache: config.cache, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, cookieConfig: config.cookieConfig, responseLimits: config.responseLimits, secureSocket: config.secureSocket, proxy: config.proxy, socketConfig: config.socketConfig, validation: config.validation, laxDataBinding: config.laxDataBinding};
        self.clientEp = check new (serviceUrl, httpClientConfig);
    }

    # Gets the current version and other information about the Click API.
    #
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get service_information(map<string|string[]> headers = {}) returns http:Response|error {
        string resourcePath = string `/service_information`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Gets all the clickwraps for an account.
    #
    # + accountId - A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v1/accounts/[string accountId]/clickwraps(map<string|string[]> headers = {}, *ClickwrapsGetClickwrapsQueries queries) returns http:Response|error {
        string resourcePath = string `/v1/accounts/${getEncodedUri(accountId)}/clickwraps`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Creates a clickwrap for an account.
    #
    # + accountId - A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v1/accounts/[string accountId]/clickwraps(ClickwrapRequest payload, map<string|string[]> headers = {}) returns http:Response|error {
        string resourcePath = string `/v1/accounts/${getEncodedUri(accountId)}/clickwraps`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Deletes clickwraps for an account.
    #
    # + accountId - A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function delete v1/accounts/[string accountId]/clickwraps(map<string|string[]> headers = {}, *ClickwrapsDeleteClickwrapsQueries queries) returns http:Response|error {
        string resourcePath = string `/v1/accounts/${getEncodedUri(accountId)}/clickwraps`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Gets a  single clickwrap object.
    #
    # + accountId - A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings
    # + clickwrapId - The ID of the clickwrap
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v1/accounts/[string accountId]/clickwraps/[string clickwrapId](map<string|string[]> headers = {}) returns http:Response|error {
        string resourcePath = string `/v1/accounts/${getEncodedUri(accountId)}/clickwraps/${getEncodedUri(clickwrapId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Updates the user ID of a clickwrap.
    #
    # + accountId - A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings
    # + clickwrapId - The ID of the clickwrap
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function put v1/accounts/[string accountId]/clickwraps/[string clickwrapId](ClickwrapTransferRequest payload, map<string|string[]> headers = {}) returns http:Response|error {
        string resourcePath = string `/v1/accounts/${getEncodedUri(accountId)}/clickwraps/${getEncodedUri(clickwrapId)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Deletes a clickwrap and all of its versions.
    #
    # + accountId - A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings
    # + clickwrapId - The ID of the clickwrap
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function delete v1/accounts/[string accountId]/clickwraps/[string clickwrapId](map<string|string[]> headers = {}, *ClickwrapsDeleteClickwrapQueries queries) returns http:Response|error {
        string resourcePath = string `/v1/accounts/${getEncodedUri(accountId)}/clickwraps/${getEncodedUri(clickwrapId)}`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Checks if a user has agreed to a clickwrap.
    #
    # + accountId - A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings
    # + clickwrapId - The ID of the clickwrap
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/agreements(UserAgreementRequest payload, map<string|string[]> headers = {}) returns http:Response|error {
        string resourcePath = string `/v1/accounts/${getEncodedUri(accountId)}/clickwraps/${getEncodedUri(clickwrapId)}/agreements`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Gets a specific agreement for a specified clickwrap.
    #
    # + accountId - A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings
    # + agreementId - The agreement ID
    # + clickwrapId - The ID of the clickwrap
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/agreements/[string agreementId](map<string|string[]> headers = {}) returns http:Response|error {
        string resourcePath = string `/v1/accounts/${getEncodedUri(accountId)}/clickwraps/${getEncodedUri(clickwrapId)}/agreements/${getEncodedUri(agreementId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Gets the completed user agreement PDF.
    #
    # + accountId - A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings
    # + agreementId - The agreement ID
    # + clickwrapId - The ID of the clickwrap
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/agreements/[string agreementId]/download(map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/v1/accounts/${getEncodedUri(accountId)}/clickwraps/${getEncodedUri(clickwrapId)}/agreements/${getEncodedUri(agreementId)}/download`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get user agreements
    #
    # + accountId - A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings
    # + clickwrapId - The ID of the clickwrap
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/users(map<string|string[]> headers = {}, *UserAgreementsGetClickwrapAgreementsQueries queries) returns http:Response|error {
        string resourcePath = string `/v1/accounts/${getEncodedUri(accountId)}/clickwraps/${getEncodedUri(clickwrapId)}/users`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Creates a new clickwrap version.
    #
    # + accountId - A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings
    # + clickwrapId - The ID of the clickwrap
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/versions(ClickwrapRequest payload, map<string|string[]> headers = {}) returns http:Response|error {
        string resourcePath = string `/v1/accounts/${getEncodedUri(accountId)}/clickwraps/${getEncodedUri(clickwrapId)}/versions`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Deletes the versions of a clickwrap.
    #
    # + accountId - A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings
    # + clickwrapId - The ID of the clickwrap
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function delete v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/versions(map<string|string[]> headers = {}, *ClickwrapVersionsDeleteClickwrapVersionsQueries queries) returns http:Response|error {
        string resourcePath = string `/v1/accounts/${getEncodedUri(accountId)}/clickwraps/${getEncodedUri(clickwrapId)}/versions`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Gets a specific version from a clickwrap.
    #
    # + accountId - A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings
    # + clickwrapId - The ID of the clickwrap
    # + version - The version ID or the version number
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/versions/[string version](map<string|string[]> headers = {}) returns http:Response|error {
        string resourcePath = string `/v1/accounts/${getEncodedUri(accountId)}/clickwraps/${getEncodedUri(clickwrapId)}/versions/${getEncodedUri(version)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Updates a specific version of a clickwrap.
    #
    # + accountId - A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings
    # + clickwrapId - The ID of the clickwrap
    # + version - The version ID or the version number
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function put v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/versions/[string version](ClickwrapRequest payload, map<string|string[]> headers = {}) returns http:Response|error {
        string resourcePath = string `/v1/accounts/${getEncodedUri(accountId)}/clickwraps/${getEncodedUri(clickwrapId)}/versions/${getEncodedUri(version)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Deletes a specific version of a clickwrap.
    #
    # + accountId - A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings
    # + clickwrapId - The ID of the clickwrap
    # + version - The version ID or the version number
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function delete v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/versions/[string version](map<string|string[]> headers = {}) returns http:Response|error {
        string resourcePath = string `/v1/accounts/${getEncodedUri(accountId)}/clickwraps/${getEncodedUri(clickwrapId)}/versions/${getEncodedUri(version)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Gets the agreement responses for a clickwrap version.
    #
    # + accountId - A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings
    # + clickwrapId - The ID of the clickwrap
    # + version - The version ID of the version number
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v1/accounts/[string accountId]/clickwraps/[string clickwrapId]/versions/[string version]/users(map<string|string[]> headers = {}, *UserAgreementsGetClickwrapVersionAgreementsQueries queries) returns http:Response|error {
        string resourcePath = string `/v1/accounts/${getEncodedUri(accountId)}/clickwraps/${getEncodedUri(clickwrapId)}/versions/${getEncodedUri(version)}/users`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }
}
