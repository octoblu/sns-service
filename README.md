# SNS Service

## Usage

### Send Message

**Endpoint:** /message

**Body Params:**
  - arn
  - deviceId
  - message

**Example**

````
curl -XPOST http://sns.octoblu/message \
  -d '{"arn": "arn:aws:sns:us-west-2:#####:app/APNS_SANDBOX/####", "deviceId":"b73b036f-bfcf-4f2a-bad9-3157e6a6c124", "message": "Hello there friendly device"}' \
  -H 'Content-Type: application/json'
````
