# Inception-of-Things

## This 42 project introduce you the base notions for beginning a DevOps journey.

It's a really good project for having the base of a DevOps. We learn What is [Kubernetes](https://kubernetes.io/), what is [ArgoCD](https://argo-cd.readthedocs.io/en/stable/), [Vagrant](https://developer.hashicorp.com/vagrant), and others...

BUT, it's not just about the tools used, but also the **DevOps notions and concepts**, like the *GitOps Model*, *CI/CD*, *Pipeline*, etc... Being a DevOps is an art ✨. These notions and concepts are extremly important to know. Without them, It can be really complicated to understand the work of a DevOps. His job is to simplify all the workflow starting to the dev who wants to update its code, and the moment of the code is deployed and running on the productuon environment.

> ### We read a LOOOOOOT of documentation of this project, and we compiled them in the [<u>wiki section</u>](https://github.com/Nimpoo/Inception-of-Things/wiki) of this repository. The wiki follow the subject, everything is addressed chronologically in relation to the project (parts 1, 2 and 3). Take this [<u>wiki section</u>](https://github.com/Nimpoo/Inception-of-Things/wiki) as a guide/walkthrough for doing the project OR learn about the world of a DevOps (the Bonus Part is not in the wiki).

---

We decided to not absolutely automates everything for not losing our correctors during the evaluations defense, we had conclued that will be more clear if we do the action during the corrections. But we could have done it would even be DevOps friendly.


The project is divided in 3 part, and a bonus part. Each part learn you some tools and new concepts to know.

# Part 1 - Vagrant and K3s

This part is the simpler: Create 2 virtual machines with Vagrant, and install K3s in them. One in controller mode, and the other in agent mode.

In this part, you learn **how to use Vagrant**, and, the most important, **create your first Kubernetes cluster**. Create a Kubernetes cluster imply to know HOW Kubernetes works. This part can be simple, but this is the starting point for understanding Kubernetes.

# Part 2 - Kubernetes Objects, cluster management and multiple application deployment

This part is more concrete: **deploy 3 web application in your Kubernetes Cluster**. Here, you understand more of WHAT Kubernetes IS USED FOR, and how to manage it after the cluster is created.

Kubernetes comes with a lot of new notions and concept, like *Kubernetes Object*, *Nodes*, *Pod*, etc... And it's the moment to learn more how to manage a Kubernetes Cluster.

# Part 3 - ArgoCD, K3d, GitOps model, and a lot of things

This part introduce the concept of **CI/CD** and **GitOps**, and how **ArgoCD is a powerful tool for deploying a new versin of an application**.

Here you will create your first **Continuous Deployement and Delivery Pipeline**. The goal of this part ? Describe your application in a remote repository (GitHub), and watch how the new version of your desired app (declared in your separate repo) is redeployed in your cluster by using ArgoCD: you need to follow the GitOps model.

# Bonus Part - Same as the Part 3, but with a twist

You need to do the same thing as the previous part, but **your remote repository need to be host in your own Kubernetes Cluster**. Stop using https://github.com, go install your own GitLab instance in your Kubernetes Cluster and host all of your code inside !!!

Your learn how to use [Helm](https://helm.sh/), the "package manager for Kubernetes", for install a GitLab instance in your Kubernetes Cluster.

# Summary
1. [Part 1 of the subject](p1/) - From [Chapter I - Vagrant](https://github.com/Nimpoo/Inception-of-Things/wiki/I-%E2%80%90-Vagrant) to [Chapter III - K3s](https://github.com/Nimpoo/Inception-of-Things/wiki/III-%E2%80%90-K3s) in the [wiki](https://github.com/Nimpoo/Inception-of-Things/wiki)
2. [Part 2 of the subject](p2/) - [Chapter IV - Creation of an app](https://github.com/Nimpoo/Inception-of-Things/wiki/IV-%E2%80%90-Creation-of-an-app) in the [wiki](https://github.com/Nimpoo/Inception-of-Things/wiki)
3. [Part 1 of the subject](p3/) - [Chapter V - ArgoCD, CI CD, GitOps Model](https://github.com/Nimpoo/Inception-of-Things/wiki/V-%E2%80%90-ArgoCD,-CI-CD,-GitOps-Model) in the [wiki](https://github.com/Nimpoo/Inception-of-Things/wiki)
4. [Bonus Part](bonus/)

<br />

## MADE BY TWO REAL BROS :

<table>
  <tr>
    <td align="center"><a href="https://github.com/noalexan/"><img src="https://avatars.githubusercontent.com/u/102285721?v=4" width="100px;" alt=""/><br /><sub><b>Noah (noalexan)</b></sub></a><br /><a href="https://profile.intra.42.fr/users/noalexan" title="Intra 42"><img src="https://img.shields.io/badge/Nice-FFFFFF?style=plastic&logo=42&logoColor=000000" alt="Intra 42"/></a></td>
    <td align="center"><a href="https://github.com/nimpoo/"><img src="https://avatars.githubusercontent.com/u/91483405?v=4" width="100px;" alt=""/><br /><sub><b>Nimpô (mayoub)</b></sub></a><br /><a href="https://profile.intra.42.fr/users/mayoub" title="Intra 42"><img src="https://img.shields.io/badge/Nice-FFFFFF?style=plastic&logo=42&logoColor=000000" alt="Intra 42"/></a></td>
  </tr>
</table>
