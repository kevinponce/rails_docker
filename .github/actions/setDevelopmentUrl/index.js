import { getOctokit, context } from "@actions/github";
import { getInput } from "@actions/core";

const token = getInput("token", { required: true, trimWhitespace: true })

console.log(token);
console.log(context);

const github = getOctokit(token, {
  previews: ["ant-man-preview", "flash-preview"],
});

console.log(github.rest.repos.createDeploymentStatus);

// github.rest.repos.createDeploymentStatus({
//   owner: context.owner,
//   repo: context.repo,
//   deployment_id: parseInt(stepArgs.deploymentID, 10),
//   state: newStatus,
//   description: description,
//   ref: context.ref,

//   // only set environment_url if deployment worked
//   environment_url: newStatus === "success" ? stepArgs.envURL : "",
//   // set log_url to action by default
//   log_url: logsURL,
//   // if we are overriding previous deployments, let GitHub deactivate past
//   // deployments for us as a fallback, or see if a user explicitly wants to
//   // use this feature.
//   auto_inactive: stepArgs.override || stepArgs.autoInactive,
// });
