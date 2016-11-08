/**
 * Simple trigger to demonstrate how to re-parent / share
 * content documents with master records after a merge operation.
 *
 * The "merged" (aka, deleted) records go away and break the links.
 * However, the documents are not then shared to the master record.
 *
 * This trigger handles the delete events to re-share the documents.
 *
 * Inspired by Gorav Seth, https://success.salesforce.com/0D53A00002uKsks
 *
 * Developed by Doug Ayers, douglascayers.com
 */
trigger ContactMergeTrigger on Contact ( before delete, after delete ) {

    new SObjectFileMergeTriggerHandler().handleMerge();

}