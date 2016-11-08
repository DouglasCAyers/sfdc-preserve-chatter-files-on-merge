/**
 * Inspired by Gorav Seth, https://success.salesforce.com/0D53A00002uKsks
 *
 * Developed by Doug Ayers, douglascayers.com
 */
@isTest
private class SObjectFileMergeTriggerHandlerTest {

    @isTest
    static void test_merge_accounts() {

        Account acct1 = new Account(
            name = 'Account 1'
        );

        Account acct2 = new Account(
            name = 'Account 2'
        );

        insert new List<Account>{ acct1, acct2 };

        ContentVersion cv = new ContentVersion(
            versionData = Blob.valueOf( 'Hello World' ),
            title = 'Message',
            pathOnClient = '/'
        );

        insert cv;

        cv = [ SELECT id, contentDocumentId FROM ContentVersion WHERE id = :cv.id ];

        ContentDocumentLink cdl = new ContentDocumentLink(
            linkedEntityId = acct2.id,
            contentDocumentId = cv.contentDocumentId,
            shareType = 'V'
        );

        insert cdl;

        Test.startTest();

        Database.merge( acct1, acct2 );

        Test.stopTest();

        System.assertEquals( 1, [ SELECT count() FROM ContentDocumentLink WHERE linkedEntityId = :acct1.id ] );

    }

    @isTest
    static void test_merge_contacts() {

        Contact cont1 = new Contact(
            firstName = 'Contact 1',
            lastName = 'Test'
        );

        Contact cont2 = new Contact(
            firstName = 'Contact 2',
            lastName = 'Test'
        );

        insert new List<Contact>{ cont1, cont2 };

        ContentVersion cv = new ContentVersion(
            versionData = Blob.valueOf( 'Hello World' ),
            title = 'Message',
            pathOnClient = '/'
        );

        insert cv;

        cv = [ SELECT id, contentDocumentId FROM ContentVersion WHERE id = :cv.id ];

        ContentDocumentLink cdl = new ContentDocumentLink(
            linkedEntityId = cont2.id,
            contentDocumentId = cv.contentDocumentId,
            shareType = 'V'
        );

        insert cdl;

        Test.startTest();

        Database.merge( cont1, cont2 );

        Test.stopTest();

        System.assertEquals( 1, [ SELECT count() FROM ContentDocumentLink WHERE linkedEntityId = :cont1.id ] );

    }

    @isTest
    static void test_merge_leads() {

        Lead ld1 = new Lead(
            firstName = 'Lead 1',
            lastName = 'Test',
            company = 'Acme'
        );

        Lead ld2 = new Lead(
            firstName = 'Lead 2',
            lastName = 'Test',
            company = 'Acme'
        );

        insert new List<Lead>{ ld1, ld2 };

        ContentVersion cv = new ContentVersion(
            versionData = Blob.valueOf( 'Hello World' ),
            title = 'Message',
            pathOnClient = '/'
        );

        insert cv;

        cv = [ SELECT id, contentDocumentId FROM ContentVersion WHERE id = :cv.id ];

        ContentDocumentLink cdl = new ContentDocumentLink(
            linkedEntityId = ld2.id,
            contentDocumentId = cv.contentDocumentId,
            shareType = 'V'
        );

        insert cdl;

        Test.startTest();

        Database.merge( ld1, ld2 );

        Test.stopTest();

        System.assertEquals( 1, [ SELECT count() FROM ContentDocumentLink WHERE linkedEntityId = :ld1.id ] );

    }

}