# policy_elasticseach
Script that changes retention time in elasticsearch

Index Lifecycle Management Policy
Overview
This repository contains an Elasticsearch Index Lifecycle Management (ILM) policy configuration. ILM is a feature in Elasticsearch that allows you to manage the lifecycle of your indices. It helps you automate the process of transitioning indices through different phases based on specified conditions.

Policy Configuration
Policy Object
The root object, policy, defines the index lifecycle policy and contains all the phases and actions that will be applied to the indices associated with this policy.

Phases Object
Within the policy, the phases object contains the different phases of an index's lifecycle: hot, warm, cold, and delete.

Hot Phase
The hot phase is the first phase of the index lifecycle and is where active indices reside. During this phase, indices receive a large amount of new data. Actions in this phase are designed to optimize both write and query performance.

min_age: This parameter defines the minimum age an index must have before transitioning to the next action within the hot phase. For example, "min_age": "20m" means the index must be at least 20 minutes old before any action is taken.
Actions in Hot Phase
Rollover: This action allows an index to be "rolled over" to a new index when specific criteria are met, such as size or age.
max_size: This criterion defines the maximum size an index can reach before triggering a rollover action. For example, "max_size": "50gb" initiates a rollover when the index reaches 50GB.
max_age: This criterion defines the maximum age an index can reach before triggering a rollover action. For example, "max_age": "1d" initiates a rollover when the index is 1 day old.
Delete Phase
The delete phase defines when and how indices should be deleted.

min_age: Similar to the hot phase, this parameter within the delete phase defines the minimum age the index must have before being deleted. If set to "min_age": "20m", the index will be deleted after 20 minutes of its creation or after 20 minutes in the hot phase, depending on how the policy is configured.
Actions in Delete Phase
Delete: Within the delete phase, this object contains the specific delete action to remove the index.
Additional Information
In Elasticsearch, an index can have 1 or N primary shards.
ILM policies are executed every 10 minutes, so it is normal for the index to have an age slightly larger than defined.
The ILM check interval can be adjusted, but be mindful as it may generate overhead in the environment. Please take this into consideration when making adjustments.
Feel free to customize this policy according to your specific requirements. For more information on Elasticsearch Index Lifecycle Management, refer to the official Elasticsearch documentation.
