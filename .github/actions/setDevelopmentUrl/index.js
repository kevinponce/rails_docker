import { getOctokit } from "@actions/github";
import { getInput } from "@actions/core";

console.log("@@@@@@@@@")

const token = getInput("token", { required: true, trimWhitespace: true })

console.log(token);

const github = getOctokit(token, {
  previews: ["ant-man-preview", "flash-preview"],
});

console.log(github.rest.repos.createDeploymentStatus);
