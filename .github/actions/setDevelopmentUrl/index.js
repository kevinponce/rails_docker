import { getOctokit, context } from "@actions/github";
import { getInput } from "@actions/core";

(async () => {
  const token = getInput("token", { required: true, trimWhitespace: true })

  console.log(getInput("deployment_id", { required: false, trimWhitespace: true }));
  const branch = getInput("branch", { required: false, trimWhitespace: true });

  

  console.log({ token: token });
  console.log('^^^^^')

  const github = getOctokit(token, {
    previews: ["ant-man-preview", "flash-preview"],
  });

  console.log(context.owner)
  console.log(context.repo)
  console.log(context.ref)
  console.log(context.repo.owner)
  console.log('$$$$$$$$$$$$$$$')

  const createDeploymentResp = await github.rest.repos.createDeployment({
    owner: context.repo.owner,
    repo: context.repo.repo,
    ref: context.ref,
    environment: branch, // "qa",
  });

  console.log(createDeploymentResp);

  const deploymentID = createDeploymentResp.data.id

  console.log(deploymentID);

  // TODO: pass in
  const state = "success";
  const environmentUrl = "https://google.com";

  const resp = await github.rest.repos.createDeploymentStatus({
    owner: context.repo.owner,
    repo: context.repo.repo,
    deployment_id: deploymentID,
    state: state,
    description: "Description will go here!",
    ref: context.ref,
    auto_inactive: true,
    environment: branch,

    // only set environment_url if deployment worked
    environment_url: environmentUrl,

    // set log_url to action by default
    // log_url: logsURL,
  });

  console.log(resp)

  github.log.debug("test")
  github.log.debug(resp.data.environment_url)
})();
