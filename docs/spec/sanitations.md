# Sanitations for OpenAPI specification

_Authors_: @Nuvindu \
_Reviewers_: @shafreenAnfar @ThisaruGuruge \
_Created_: 2024/03/12 \
_Updated_: 2024/02/12 \
_Edition_: Swan Lake

## Introduction

The Ballerina DocuSign Click connector facilitates integration with the [DocuSign Click API](https://developers.docusign.com/docs/click-api/reference) through the generation of client code using the [OpenAPI specification](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/blob/main/docs/spec/openapi.json). To enhance usability, the following modifications have been applied to the original specification.

1. Response descriptions
Previously, all responses for resource functions were labeled with a generic "Successful Response". This has been revised to "A successful response or an error".

2. Parameter redefinition
Similar resource methods with path parameters `versionId` and `versionNumber` have been identified as the same resource path. To resolve this, a single API now utilizes the path parameter `version`. As both instances previously had the same functionality with the only difference being the path parameter for `version`, the new API can be used for both occurrences.

## OpenAPI cli command

```bash
bal openapi -i docs/spec/openapi.json --mode client -o ballerina
```
