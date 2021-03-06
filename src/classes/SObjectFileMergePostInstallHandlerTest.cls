/*
Author: Doug Ayers
Website: https://douglascayers.com
GitHub: https://github.com/DouglasCAyers/sfdc-preserve-chatter-files-on-merge
License: BSD 3-Clause License
*/
@isTest
private class SObjectFileMergePostInstallHandlerTest {

    @isTest
    static void test_new_install() {

        Test.startTest();

        Test.testInstall( new SObjectFileMergePostInstallHandler(), null );

        Test.stopTest();

        Preserve_Files_On_Merge_Settings__c settings = Preserve_Files_On_Merge_Settings__c.getOrgDefaults();

        System.assert( String.isNotBlank( settings.id ), 'id should not be blank' );
        System.assertEquals( true, settings.Enable_Account_Trigger__c );
        System.assertEquals( true, settings.Enable_Contact_Trigger__c );
        System.assertEquals( true, settings.Enable_Lead_Trigger__c );

    }

    @isTest
    static void test_upgrade() {

        Preserve_Files_On_Merge_Settings__c preSettings = Preserve_Files_On_Merge_Settings__c.getOrgDefaults();
        preSettings.Enable_Account_Trigger__c = false;
        preSettings.Enable_Contact_Trigger__c = false;
        preSettings.Enable_Lead_Trigger__c = false;

        upsert preSettings;

        Test.startTest();

        Test.testInstall( new SObjectFileMergePostInstallHandler(), new Version( 1, 0 ) );

        Test.stopTest();

        Preserve_Files_On_Merge_Settings__c postSettings = Preserve_Files_On_Merge_Settings__c.getOrgDefaults();

        System.assertEquals( preSettings.id, postSettings.id );
        System.assertEquals( preSettings.Enable_Account_Trigger__c, postSettings.Enable_Account_Trigger__c );
        System.assertEquals( preSettings.Enable_Contact_Trigger__c, postSettings.Enable_Contact_Trigger__c );
        System.assertEquals( preSettings.Enable_Lead_Trigger__c, postSettings.Enable_Lead_Trigger__c );

    }

}
/*
BSD 3-Clause License

Copyright (c) 2017, Doug Ayers
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of the copyright holder nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/