Q: Shared Volume Exposure:  The /shared directory is accessible to all jobs on the same runner.If not properly isolated, malicious code or compromised jobs could read/write sensitive files.
Ans: Now, every time we trigger a pipeline, a new directory will be created with the GitHub runner ID. The jobs in the pipeline run will use this directory, and at the end of the run, the directory will be deleted. This ensures there is no risk of shared volume exposure.

Q: Self-Hosted Runner Risks: Self-hosted runners may be more vulnerable than managed runners. They often have broader network or file system access and could be targeted for lateral movement.
Ans: 
	•	The EKS cluster needs to be properly updated.
	•	Add-ons should be properly updated.
	•	The firewall should be very narrow and strict.
	•	EFS should not be mounted outside of EKS.

Q: Lack of Access Controls: All jobs have access to the shared directory, regardless of trust level or purpose.
Ans: 
 Now, every time we trigger a pipeline, a new directory will be created with the GitHub runner ID. The jobs in the pipeline run will use this directory, and at the end of the run, the directory will be deleted. 

Q: Potential for Data Leakage: If cleanup steps fail or are skipped, sensitive data could persist and be accessed by later jobs or workflows.
Ans: 
It’s addressed. Even if a job fails, the cleanup job will still run.
