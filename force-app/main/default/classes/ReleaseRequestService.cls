public with sharing class ReleaseRequestService {

    // Create a new Release Request
    public static Id createRequest(
        String description,
        String priority
    ) {
        Release_Request__c request =
            new Release_Request__c(
                Request_Description__c = description,
                Priority__c = priority,
                Status__c = 'Draft'
            );

        insert request;
        return request.Id;
    }

    // Update Release Request status
    public static void updateStatus(
        Id requestId,
        String newStatus
    ) {
        Release_Request__c request = [
            SELECT Id, Status__c
            FROM Release_Request__c
            WHERE Id = :requestId
            LIMIT 1
        ];

        request.Status__c = newStatus;
        update request;
    }

    // Retrieve Release Request records
    public static List<Release_Request__c> getRequests() {
        return [
            SELECT Id, Name, Status__c, Priority__c,
                   Request_Description__c
            FROM Release_Request__c
            ORDER BY CreatedDate DESC
        ];
    }
}