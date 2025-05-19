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

# Request body for working with clickwrap
public type ClickwrapRequest record {
    # Information about how an agreement is displayed
    DisplaySettings displaySettings?;
    # When **true**, requires signers who have previously agreed to this
    # clickwrap to sign again. The version number is incremented
    boolean requireReacceptance?;
    # The user ID of current owner of the clickwrap
    string transferFromUserId?;
    # An array of documents
    Document[] documents?;
    # The user ID of the new owner of the clickwrap
    string transferToUserId?;
    # The time and date when this clickwrap is activated
    record {} scheduledDate?;
    ClickwrapScheduledReacceptance scheduledReacceptance?;
    # The name of the clickwrap
    string clickwrapName?;
    # Specifies whether `scheduledReacceptance` and `scheduledDate` should be cleared. May be one of:
    # 
    # - `"scheduledReacceptance"`
    # - `"scheduledDate"`
    # - `"scheduledReacceptance,scheduledDate"`
    string fieldsToNull?;
    # Name of the clickwrap
    string name?;
    # When **true**, the next version created is a major version. When **false** the next version created is minor
    boolean isMajorVersion?;
    boolean isShared?;
    # Clickwrap status. Possible values:
    # 
    # - `active`
    # - `inactive`
    # - `deleted`
    record {} status?;
};

# Represents the Queries record for the operation: Clickwraps_DeleteClickwraps
public type ClickwrapsDeleteClickwrapsQueries record {
    # A comma-separated list of clickwrap IDs to delete
    string clickwrapIds?;
};

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
    # The date when the recurrence interval starts
    record {} startDateTime?;
    # The units of the `recurrenceInterval`. Must be one of:
    # 
    # - `days`
    # - `weeks`
    # - `month`
    # - `years`
    string recurrenceIntervalType?;
};

# Represents the Queries record for the operation: ClickwrapVersions_DeleteClickwrapVersions
public type ClickwrapVersionsDeleteClickwrapVersionsQueries record {
    # A comma-separated list of clickwrap version IDs to delete
    string clickwrapVersionIds?;
};

# Information about a document
public type Document record {
    # The file extension of the document
    string fileExtension?;
    # The base64-encoded contents of the document
    string documentBase64?;
    # The name of the document
    string documentName?;
    # The HTML representation of the document
    string documentHtml?;
    # The order of document layout
    int:Signed32 'order?;
};

public type ClickwrapTransferRequest record {
    # ID of the user to transfer from
    string transferFromUserId?;
    # ID of the user to transfer to
    string transferToUserId?;
};

# Represents the Queries record for the operation: UserAgreements_GetClickwrapAgreements
public type UserAgreementsGetClickwrapAgreementsQueries record {
    # Optional. The page number to return
    @http:Query {name: "page_number"}
    string pageNumber?;
    # Optional. The earliest date to return agreements from
    @http:Query {name: "from_date"}
    string fromDate?;
    # Optional. The latest date to return agreements from
    @http:Query {name: "to_date"}
    string toDate?;
    # The client ID
    @http:Query {name: "client_user_id"}
    string clientUserId?;
    # Optional. The status of the clickwraps to return
    string status?;
};

public type UserAgreementRequest record {
    # The user ID of the client
    string clientUserId?;
    # A customer-defined string you can use in requests. This string will appear in the corresponding response
    string metadata?;
    # The host origin
    string hostOrigin?;
};

# Represents the Queries record for the operation: UserAgreements_GetClickwrapVersionAgreements
public type UserAgreementsGetClickwrapVersionAgreementsQueries record {
    # Optional. The page number to return
    @http:Query {name: "page_number"}
    string pageNumber?;
    # Optional. The earliest date to return agreements from
    @http:Query {name: "from_date"}
    string fromDate?;
    # Optional. The latest date to return agreements from
    @http:Query {name: "to_date"}
    string toDate?;
    @http:Query {name: "client_user_id"}
    string clientUserId?;
    # Clickwrap status. Possible values:
    # 
    # - `active`
    # - `inactive`
    # - `deleted`
    string status?;
};

# Represents the Queries record for the operation: Clickwraps_DeleteClickwrap
public type ClickwrapsDeleteClickwrapQueries record {
    # A comma-separated list of versions to delete
    string versions?;
};

# Information about how an agreement is displayed
public type DisplaySettings record {
    # Hosts that can host the clickwrap.
    # 
    # It is an error if the clickwrap didn't come from one of these hosts
    string[] allowedHosts?;
    # **True** if the user needs to scroll to the end of the document
    boolean mustRead?;
    # **True** if accept is required
    boolean requireAccept?;
    # **True** if the agreement is downloadable
    boolean downloadable?;
    # Position of the Accept button in the agreement. One of 
    # 
    # - `right`
    # - `left`
    string actionButtonAlignment?;
    # Display type: link or document
    string documentDisplay?;
    # The text on the decline button
    string declineButtonText?;
    # The display name of the user agreement
    string displayName?;
    # Text on the agree button
    string consentButtonText?;
    # Display format: inline or modal
    string format?;
    # **True** if the agreement has a decline checkbox
    boolean hasDeclineButton?;
    # The text on agree button
    string consentText?;
    # The host origin
    string hostOrigin?;
    # **True** if the user must view the document
    boolean mustView?;
    # When **true**, this agreement records decline actions
    boolean recordDeclineResponses?;
    # When **true**, this agreement can be be used in client-only integrations
    boolean allowClientOnly?;
    # The signing brand ID
    string brandId?;
    # **True** if send to email is applicable
    boolean sendToEmail?;
};

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    http:ClientHttp1Settings http1Settings = {};
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings = {};
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 30;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with Redirection
    http:FollowRedirects followRedirects?;
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache = {};
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with cookies
    http:CookieConfig cookieConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits = {};
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Provides settings related to client socket configuration
    http:ClientSocketConfig socketConfig = {};
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
    # Enables relaxed data binding on the client side. When enabled, `nil` values are treated as optional, 
    # and absent fields are handled as `nilable` types. Enabled by default.
    boolean laxDataBinding = true;
|};

# Represents the Queries record for the operation: Clickwraps_GetClickwraps
public type ClickwrapsGetClickwrapsQueries record {
    string shared?;
    # Optional. The page number to return
    @http:Query {name: "page_number"}
    string pageNumber?;
    # Optional. The earliest date to return agreements from
    @http:Query {name: "from_date"}
    string fromDate?;
    # Optional. The latest date to return agreements from
    @http:Query {name: "to_date"}
    string toDate?;
    # Optional. The user ID of the owner
    string ownerUserId?;
    # Optional. The status of the clickwraps to filter by. One of:
    # 
    # - `active`
    # - `inactive`
    string status?;
};
