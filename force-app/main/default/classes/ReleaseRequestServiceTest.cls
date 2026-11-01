@IsTest
private class ReleaseRequestServiceTest {

    @IsTest
    static void testCreateRequest() {

        Test.startTest();

        Id requestId = ReleaseRequestService.createRequest(
            'Testing release deployment',
            'High'
        );

        Test.stopTest();

        Release_Request__c result = [
            SELECT Id, Request_Description__c,
                   Priority__c, Status__c
            FROM Release_Request__c
            WHERE Id = :requestId
        ];

        System.assertEquals(
            'Testing release deployment',
            result.Request_Description__c
        );
        System.assertEquals('High', result.Priority__c);
        System.assertEquals('Draft', result.Status__c);
    }

    @IsTest
    static void testUpdateStatus() {

        Release_Request__c request = new Release_Request__c(
            Request_Description__c = 'Testing status update',
            Priority__c = 'High',
            Status__c = 'Draft'
        );

        insert request;

        Test.startTest();

        ReleaseRequestService.updateStatus(
            request.Id,
            'Submitted'
        );

        Test.stopTest();

        Release_Request__c updatedRequest = [
            SELECT Id, Status__c
            FROM Release_Request__c
            WHERE Id = :request.Id
        ];

        System.assertEquals(
            'Submitted',
            updatedRequest.Status__c
        );
    }

    @IsTest
    static void testGetRequests() {

        Release_Request__c request = new Release_Request__c(
            Request_Description__c = 'Testing retrieval',
            Priority__c = 'High',
            Status__c = 'Draft'
        );

        insert request;

        Test.startTest();

        List<Release_Request__c> results =
            ReleaseRequestService.getRequests();

        Test.stopTest();

        System.assert(results.size() > 0);
        System.assertEquals(
            request.Id,
            results[0].Id
        );
    }
}