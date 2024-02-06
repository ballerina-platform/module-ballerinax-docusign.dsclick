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

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    ClientHttp1Settings http1Settings?;
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings?;
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache?;
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits?;
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
    # Configurations related to client authentication
    http:ClientAuthConfig? auth = ();
|};

# Provides settings related to HTTP/1.x protocol.
public type ClientHttp1Settings record {|
    # Specifies whether to reuse a connection for multiple requests
    http:KeepAlive keepAlive = http:KEEPALIVE_AUTO;
    # The chunking behaviour of the request
    http:Chunking chunking = http:CHUNKING_AUTO;
    # Proxy server related options
    ProxyConfig proxy?;
|};

# Proxy server configurations to be used with the HTTP client endpoint.
public type ProxyConfig record {|
    # Host name of the proxy server
    string host = "";
    # Proxy server port
    int port = 0;
    # Proxy server username
    string userName = "";
    # Proxy server password
    @display {label: "", kind: "password"}
    string password = "";
|};

# Request body for working with clickwrap.
public type ClickwrapRequest record {
    # The name of the clickwrap.
    string clickwrapName?;
    # Information about how an agreement is displayed.
    DisplaySettings displaySettings?;
    # An array of documents.
    Document[] documents?;
    # Specifies whether `scheduledReacceptance` and `scheduledDate` should be cleared. May be one of:
    # 
    # - `"scheduledReacceptance"`
    # - `"scheduledDate"`
    # - `"scheduledReacceptance,scheduledDate"`
    string fieldsToNull?;
    # When **true**, the next version created is a major version. When **false** the next version created is minor.
    boolean isMajorVersion?;
    # 
    boolean isShared?;
    # Name of the clickwrap.
    string name?;
    # When **true**, requires signers who have previously agreed to this
    # clickwrap to sign again. The version number is incremented.
    boolean requireReacceptance?;
    # The time and date when this clickwrap is activated.
    string scheduledDate?;
    # 
    ClickwrapScheduledReacceptance scheduledReacceptance?;
    # Clickwrap status. Possible values:
    # 
    # - `active`
    # - `inactive`
    # - `deleted`
    string status?;
    # The user ID of current owner of the clickwrap.
    string transferFromUserId?;
    # The user ID of the new owner of the clickwrap.
    string transferToUserId?;
};

# 
public type ClickwrapVersion record {
    # The unique version ID, a GUID, of this clickwrap version.
    string clickwrapVersionId?;
    # The time that the clickwrap was created.
    record {} createdTime?;
    # The time that the clickwrap was last modified.
    record {} lastModified?;
    # The user ID of the last user who modified this clickwrap.
    string lastModifiedBy?;
    # The user ID of the owner of this clickwrap.
    string ownerUserId?;
    # When **true**, requires signers who have previously agreed to this
    # clickwrap to sign again. The version number is incremented.
    boolean requireReacceptance?;
    # The time and date when this clickwrap is activated.
    record {} scheduledDate?;
    # 
    ClickwrapScheduledReacceptance scheduledReacceptance?;
    # Clickwrap status. Possible values:
    # 
    # - `active`
    # - `inactive`
    # - `deleted`
    string status?;
    # The ID of the version.
    string versionId?;
    # Version of the clickwrap.
    string versionNumber?;
};

# 
public type ClickwrapScheduledReacceptance record {
    # The time between recurrences specified in `recurrenceIntervalType` units.
    # 
    # The minimum and maximum values depend on `recurrenceIntervalType`:
    # 
    # - `days`: 1 - 365
    # - `weeks`: 1 - 52
    # - `months`: 1 - 12
    # - `years`: 1
    int:Signed32 recurrenceInterval?;
    # The units of the `recurrenceInterval`. Must be one of:
    # 
    # - `days`
    # - `weeks`
    # - `month`
    # - `years`
    string recurrenceIntervalType?;
    # The date when the recurrence interval starts.
    record {} startDateTime?;
};

# 
public type UserAgreementResponse record {
    # A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings.
    string accountId?;
    # Date that the client last completed the agreement.
    # 
    # This property is null if `agreementUrl` is not null and `status` is not  `agreed`.
    record {} agreedOn?;
    # The agreement ID.
    string agreementId?;
    # When not null, an agreement is required for user specified by  `clientUserId`.
    # 
    # When missing the user specified by `clientUserId`
    # has already agreed and does not require a new acceptance.
    # 
    # Use this URL to render the agreement in a web page.
    # 
    # <!--
    # or redirected to when providing redirect_url as a query paramter.
    # -->
    string agreementUrl?;
    # The ID of the clickwrap.
    string clickwrapId?;
    # The user ID of the client.
    string clientUserId?;
    # The customer-branded HTML with the Electronic Record and Signature Disclosure information
    string consumerDisclosureHtml?;
    # The date when the clickwrap was created. May be null.
    record {} createdOn?;
    # The date when the user declined the most recent required agreement.
    # 
    # This property is valid only when `status` is `declined`. Otherwise it is null.
    record {} declinedOn?;
    # An array of documents.
    Document[] documents?;
    # A customer-defined string you can use in requests. This string will appear in the corresponding response.
    string metadata?;
    # Information about how an agreement is displayed.
    DisplaySettings settings?;
    # User agreement status. One of:
    # 
    # - `created`
    # - `agreed`
    # - `declined`
    string status?;
    # The human-readable semver version string.
    string version?;
    # The ID of the version.
    string versionId?;
    # Version of the clickwrap.
    int:Signed32 versionNumber?;
};

# 
public type ClickwrapVersionResponse record {
    # A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings.
    string accountId?;
    # The ID of the clickwrap.
    string clickwrapId?;
    # The name of the clickwrap.
    string clickwrapName?;
    # The unique version ID, a GUID, of this clickwrap version.
    string clickwrapVersionId?;
    # The time that the clickwrap was created.
    string createdTime?;
    # Information about how an agreement is displayed.
    DisplaySettings displaySettings?;
    # An array of documents.
    Document[] documents?;
    # The time that the clickwrap was last modified.
    string lastModified?;
    # The user ID of the last user who modified this clickwrap.
    string lastModifiedBy?;
    # The user ID of the owner of this clickwrap.
    string ownerUserId?;
    # When **true**, requires signers who have previously agreed to this
    # clickwrap to sign again. The version number is incremented.
    boolean requireReacceptance?;
    # The time and date when this clickwrap is activated.
    string scheduledDate?;
    # 
    ClickwrapScheduledReacceptance scheduledReacceptance?;
    # Clickwrap status. Possible values:
    # 
    # - `active`
    # - `inactive`
    # - `deleted`
    string status?;
    # The ID of the version.
    string versionId?;
    # Version of the clickwrap.
    string versionNumber?;
};

# 
public type ClickwrapVersionDeleteResponse record {
    # The unique version ID, a GUID, of this clickwrap version.
    string clickwrapVersionId?;
    # The time that the clickwrap was created.
    string createdTime?;
    # A message describing the result of deletion request. One of:
    # 
    # - `alreadyDeleted`: Clickwrap is already deleted.
    # - `deletionSuccess`: Successfully deleted the clickwrap.
    # - `deletionFailure`: Failed to delete the clickwrap.
    # - `cannotDelete`: Active clickwrap version cannot be deleted.
    string deletionMessage?;
    # **True** if the clickwrap was deleted successfully. **False** otherwise.
    boolean deletionSuccess?;
    # The time that the clickwrap was last modified.
    string lastModified?;
    # The user ID of the last user who modified this clickwrap.
    string lastModifiedBy?;
    # The user ID of the owner of this clickwrap.
    string ownerUserId?;
    # When **true**, requires signers who have previously agreed to this
    # clickwrap to sign again. The version number is incremented.
    boolean requireReacceptance?;
    # The time and date when this clickwrap is activated.
    string scheduledDate?;
    # 
    ClickwrapScheduledReacceptance scheduledReacceptance?;
    # Clickwrap status. Possible values:
    # 
    # - `active`
    # - `inactive`
    # - `deleted`
    string status?;
    # The ID of the version.
    string versionId?;
    # Version of the clickwrap.
    string versionNumber?;
};

# Error details.
public type ErrorDetails record {
    # The error code.
    string errorCode?;
    # The error message.
    string message?;
};

# Information about a document.
public type Document record {
    # The base64-encoded contents of the document.
    string documentBase64?;
    # The HTML representation of the document.
    string documentHtml?;
    # The name of the document.
    string documentName?;
    # The file extension of the document.
    string fileExtension?;
    # The order of document layout.
    int:Signed32 'order?;
};

# 
public type ClickwrapsDeleteResponse record {
    # 
    ClickwrapDeleteResponse[] clickwraps?;
};

# 
public type ClickwrapTransferRequest record {
    # ID of the user to transfer from.
    string transferFromUserId?;
    # ID of the user to transfer to.
    string transferToUserId?;
};

# 
public type ClickwrapVersionsPagedResponse record {
    # A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings.
    string accountId?;
    # The ID of the clickwrap.
    string clickwrapId?;
    # The name of the clickwrap.
    string clickwrapName?;
    # Number of pages remaining in the response.
    int:Signed32 minimumPagesRemaining?;
    # The number of the current page.
    int:Signed32 page?;
    # The number of items per page.
    int:Signed32 pageSize?;
    # An array of clickwrap versions.
    ClickwrapVersion[] versions?;
};

# 
public type ClickwrapAgreementsResponse record {
    # User agreements from this datetime.
    record {} beginCreatedOn?;
    # Number of pages remaining in the response.
    int:Signed32 minimumPagesRemaining?;
    # The number of the current page.
    int:Signed32 page?;
    # The number of items per page.
    int:Signed32 pageSize?;
    # An array of user agreements.
    UserAgreementResponse[] userAgreements?;
};

# A paged collection of clickwraps.
public type ClickWraps record {
    # An array of clickwraps.
    ClickwrapVersionSummaryResponse[] clickwraps?;
    # Number of pages remaining in the response.
    int:Signed32 minimumPagesRemaining?;
    # The number of the current page.
    int:Signed32 page?;
    # The number of items per page.
    int:Signed32 pageSize?;
};

# 
public type ClickwrapVersionSummaryResponse record {
    # A GUID that identifies your account.
    # This value is automatically generated by
    # DocuSign for any account you create. Copy the
    # value from the **API Account ID** field in
    # the **API and Keys** page in
    # eSignature Settings.
    string accountId?;
    # The ID of the clickwrap.
    string clickwrapId?;
    # The name of the clickwrap.
    string clickwrapName?;
    # The unique version ID, a GUID, of this clickwrap version.
    string clickwrapVersionId?;
    # The time that the clickwrap was created.
    string createdTime?;
    # The time that the clickwrap was last modified.
    string lastModified?;
    # The user ID of the last user who modified this clickwrap.
    string lastModifiedBy?;
    # The user ID of the owner of this clickwrap.
    string ownerUserId?;
    # When **true**, requires signers who have previously agreed to this
    # clickwrap to sign again. The version number is incremented.
    boolean requireReacceptance?;
    # The time and date when this clickwrap is activated.
    string scheduledDate?;
    # 
    ClickwrapScheduledReacceptance scheduledReacceptance?;
    # Clickwrap status. Possible values:
    # 
    # - `active`
    # - `inactive`
    # - `deleted`
    string status?;
    # The ID of the version.
    string versionId?;
    # Version of the clickwrap.
    string versionNumber?;
};

# 
public type ServiceInformation record {
    # 
    string buildBranch?;
    # 
    string buildBranchDeployedDateTime?;
    # 
    string buildSHA?;
    # The internal build version information.
    string buildVersion?;
    # An array of URLs (strings) of related sites.
    string[] linkedSites?;
    # An array of `serviceVersion` objects.
    ServiceVersion[] serviceVersions?;
};

# 
public type ClickwrapVersionsDeleteResponse record {
    # The ID of the clickwrap.
    string clickwrapId?;
    # The name of the clickwrap.
    string clickwrapName?;
    # An array delete responses.
    ClickwrapVersionDeleteResponse[] versions?;
};

# 
public type UserAgreementRequest record {
    # The user ID of the client.
    string clientUserId?;
    # The host origin.
    string hostOrigin?;
    # A customer-defined string you can use in requests. This string will appear in the corresponding response.
    string metadata?;
};

# 
public type ClickwrapDeleteResponse record {
    # The ID of the clickwrap.
    string clickwrapId?;
    # The name of the clickwrap.
    string clickwrapName?;
    # A message describing the result of deletion request. One of:
    # 
    # - `alreadyDeleted`: Clickwrap is already deleted.
    # - `deletionSuccess`: Successfully deleted the clickwrap.
    # - `deletionFailure`: Failed to delete the clickwrap.
    # - `cannotDelete`: Active clickwrap version cannot be deleted.
    string deletionMessage?;
    # **True** if the clickwrap was deleted successfully. **False** otherwise.
    boolean deletionSuccess?;
    # Clickwrap status. Possible values:
    # 
    # - `active`
    # - `inactive`
    # - `deleted`
    string status?;
};

# 
public type ServiceVersion record {
    # The human-readable semver version string.
    string version?;
    # The URL where this version of the API can be found.
    string versionUrl?;
};

# Information about how an agreement is displayed.
public type DisplaySettings record {
    # Position of the Accept button in the agreement. One of 
    # 
    # - `right`
    # - `left`
    string actionButtonAlignment?;
    # When **true**, this agreement can be be used in client-only integrations
    boolean allowClientOnly?;
    # Hosts that can host the clickwrap.
    # 
    # It is an error if the clickwrap didn't come from one of these hosts.
    string[] allowedHosts?;
    # The signing brand ID.
    string brandId?;
    # Text on the agree button.
    string consentButtonText?;
    # The text on agree button.
    string consentText?;
    # The text on the decline button.
    string declineButtonText?;
    # The display name of the user agreement.
    string displayName?;
    # Display type: link or document
    string documentDisplay?;
    # **True** if the agreement is downloadable.
    boolean downloadable?;
    # Display format: inline or modal.
    string format?;
    # **True** if the agreement has a decline checkbox.
    boolean hasDeclineButton?;
    # The host origin.
    string hostOrigin?;
    # **True** if the user needs to scroll to the end of the document.
    boolean mustRead?;
    # **True** if the user must view the document.
    boolean mustView?;
    # When **true**, this agreement records decline actions.
    boolean recordDeclineResponses?;
    # **True** if accept is required.
    boolean requireAccept?;
    # **True** if send to email is applicable.
    boolean sendToEmail?;
};

# 
public type ClickwrapVersionsResponse record {
    # An array of `clickwrapVersionSummaryResponse` objects.
    ClickwrapVersionSummaryResponse[] clickwraps?;
    # Number of pages remaining in the response.
    int:Signed32 minimumPagesRemaining?;
    # The number of the current page.
    int:Signed32 page?;
    # The number of items per page.
    int:Signed32 pageSize?;
};

public type BadRequestAnydata record {|
    *http:BadRequest;
    anydata body;
|};
