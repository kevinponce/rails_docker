import { getOctokit, context } from "@actions/github";
import { getInput } from "@actions/core";

(async () => {
  const token = getInput("token", { required: true, trimWhitespace: true })

  console.log(getInput("deployment_id", { required: false, trimWhitespace: true }));
  const branch = getInput("branch", { required: false, trimWhitespace: true });
  console.log({ ref: getInput("ref", { required: false, trimWhitespace: true }) });

  console.log({ token: token });
  console.log('^^^^^')

  const github = getOctokit(token, {
    previews: ["ant-man-preview", "flash-preview"],
  });

  const { owner, repo } = context.repo;
  const { sha } = context

  console.log(context.owner)
  console.log(context.repo)
  console.log(context.ref)
  console.log(context.repo.owner)
  console.log('$$$$$$$$$$$$$$$')

  console.log(JSON.stringify(context, null, 2))

  // const sdf = await github.rest.repos.listDeployments({
  //   owner,
  //   repo: context.repo.repo,
  // });

  // console.log(sdf)

  console.log('$$$$$$$$$')

  const createDeploymentResp = await github.rest.repos.createDeployment({
    owner,
    repo,
    ref: branch, // context.ref,
    environment: 'qa',
  });

  console.log(JSON.stringify(createDeploymentResp, null, 2))

  const deploymentID = createDeploymentResp.data.id

  console.log(deploymentID);

  // // TODO: pass in
  const state = "success";
  const environmentUrl = "https://google.com";

  const resp = await github.rest.repos.createDeploymentStatus({
    owner,
    repo,
    deployment_id: deploymentID,
    state: state,
    description: "Description will go here!",
    ref: sha, // context.ref,
    auto_inactive: true,
    environment: branch,

    // only set environment_url if deployment worked
    environment_url: environmentUrl,

    // set log_url to action by default
    // log_url: logsURL,

    logsURL: `https://github.com/${owner}/${repo}/commit/${sha}/checks`,
  });

  console.log(JSON.stringify(resp, null, 2))

  // github.log.debug("test")
  // github.log.debug(resp.data.environment_url)
})();
