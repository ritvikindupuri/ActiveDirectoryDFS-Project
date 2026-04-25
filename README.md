# Centralized Windows Enterprise Infrastructure Simulation

## Executive Summary
This project demonstrates the design and implementation of a centralized Windows enterprise infrastructure, simulating real-world domain operations. The environment is architected around an Active Directory (AD) core to manage identity, resource governance, remote administration, and high-availability file services.

The system emphasizes a security-first approach through **Role-Based Access Control (RBAC)**, centralized patch management via **WSUS**, and headless administrative control through **PowerShell Remoting**, reflecting a mature, production-ready enterprise model.

## Tech Stack & Frameworks
* **Identity & Directory Services**: Active Directory (AD DS), DNS, LDAP, Kerberos.
* **Remote Administration**: PowerShell Remoting (WinRM).
* **File Services**: Distributed File System (DFS-N & DFS-R).
* **Patch Management**: Windows Server Update Services (WSUS).
* **Governance**: Group Policy Objects (GPO), Role-Based Access Control (RBAC).

---

## System Architecture

The infrastructure connects domain controllers, specialized resource servers, and administrative workstations within a unified AD domain. Centralized Group Policy enforcement ensures consistent security and configuration across the entire machine fleet.

<p align="center">
  <img src=".assets/System%20Architecture.png" alt="Enterprise System Architecture" width="850"/>
</p>
<p align="center"><strong>Figure 1</strong>: High-level architectural diagram showcasing domain inter-connectivity and service distribution.</p>

---

## Part 1: Identity Governance & Access Control

Identity management is centralized within Active Directory, utilizing a clean Organizational Unit (OU) structure to manage domain users and machines. Authentication is handled via **Kerberos**, with directory operations supported through **LDAP**.

### Role-Based Delegation (RBAC)
Instead of assigning direct, broad privileges, access is governed through membership in scoped security groups. For example, a dedicated **Printer Admin** account is restricted to managing print services through membership in the **Print Operators** group, successfully demonstrating the principle of least privilege (PoLP).

<p align="center">
  <img src=".assets/Identity.png" alt="Active Directory OU Structure" width="800"/>
</p>
<p align="center"><strong>Figure 2</strong>: Active Directory Organizational Unit (OU) design for centralized identity governance.</p>

<p align="center">
  <img src=".assets/Admin%20security%20for%20Printer.png" alt="Role Based Access Control Proof" width="800"/>
</p>
<p align="center"><strong>Figure 3</strong>: Security descriptors proving role-based delegation for resource management.</p>

---

## Part 2: High-Availability File Services

To ensure data availability and seamless user access, the environment utilizes Distributed File System (DFS) technologies.

* **DFS Namespace (DFS-N)**: Provides a unified logical path for shared folders, allowing users to access data through the namespace rather than individual server IPs or hostnames.
* **DFS Replication (DFS-R)**: Maintains data consistency across multiple backend folder targets, ensuring that if one file server fails, access continues uninterrupted.

<p align="center">
  <img src=".assets/DFS%20Namespace%20Targets.png" alt="DFS Namespace Configuration" width="800"/>
</p>
<p align="center"><strong>Figure 4</strong>: DFS Namespace mapping to multiple redundant folder targets.</p>

<p align="center">
  <img src=".assets/DFS%20Replication%20proof.png" alt="DFS Replication Status" width="800"/>
</p>
<p align="center"><strong>Figure 5</strong>: Operational proof of data synchronization across the DFS replication group.</p>

<p align="center">
  <img src=".assets/DFS%20Replication%20Logs.png" alt="DFS Replication Event Logs" width="800"/>
</p>
<p align="center"><strong>Figure 6</strong>: DFS Replication Event Viewer logs confirming successful contact and configuration access.</p>

---

## Part 3: Remote Administration & Patch Management

The infrastructure is designed for headless management, significantly reducing the need for direct local logins to servers.

### PowerShell Remoting
Administrative operations are executed remotely from a dedicated workstation using PowerShell Remoting over **WinRM**. Critical services, such as the Print Spooler, are managed without direct server logins, reducing the potential attack surface of the local console.

<p align="center">
  <img src=".assets/Remote%20Admin%20(Session%20start).png" alt="PowerShell Remote Session Initialization" width="800"/>
</p>
<p align="center"><strong>Figure 7</strong>: Initializing a secure remote PowerShell session (Enter-PSSession) to a domain server.</p>

### Centralized Update Deployment (WSUS)
Patch management is centralized through **Windows Server Update Services (WSUS)**. Updates are synchronized with Microsoft Update and distributed to domain-joined machines on controlled schedules defined by Group Policy, ensuring a consistent security posture.

<p align="center">
  <img src=".assets/Remote%20Admin%20-%20Service%20Spooler.png" alt="PowerShell Remote Administration" width="800"/>
</p>
<p align="center"><strong>Figure 8</strong>: Managing critical OS services remotely via authenticated PowerShell sessions.</p>

<p align="center">
  <img src=".assets/WSUS%20Patch%20-1.png" alt="WSUS Update Dashboard" width="800"/>
</p>
<p align="center"><strong>Figure 9</strong>: WSUS initialization and synchronization status for centralized patch governance.</p>

---

## Part 4: Resource Governance (Print Services)

Shared resources are centrally managed to control job execution and security. The print server configuration includes queue prioritization to manage high-volume traffic and permission separation between standard users and administrative operators.

<p align="center">
  <img src=".assets/Printer%20infrastructure.png" alt="Print Server Infrastructure" width="800"/>
</p>
<p align="center"><strong>Figure 10</strong>: Centralized management interface displaying the deployed enterprise printer fleet.</p>

<p align="center">
  <img src=".assets/Print%20Server%20properties.png" alt="Print Server Job Prioritization" width="500"/>
</p>
<p align="center"><strong>Figure 11</strong>: Print queue properties demonstrating advanced job prioritization configuration.</p>

---

## Full Project Documentation
For a comprehensive technical breakdown—including GPO configuration tables, step-by-step implementation logs, and detailed system validation procedures—please refer to the complete project report:

**[Scalable Enterprise Infrastructure Documentation.pdf](Scalable%20Enterprise%20Infrastructure%20Documentation.pdf)**

---

## Strategic Impact & Conclusion

The successful implementation of this environment proves the efficacy of centralized management in a modern enterprise setting. By integrating identity management, file availability, and patch governance, the resulting system achieves three critical cybersecurity objectives:

1.  **Attack Surface Reduction**: By enforcing headless administration through PowerShell Remoting and limiting local login privileges, the lateral movement potential for an adversary is significantly constrained.
2.  **Operational Resilience**: The use of DFS Namespaces and Replication ensures that critical business data remains available even during hardware failure or scheduled maintenance, supporting continuous business operations.
3.  **Scalable Security Governance**: The transition from individual machine management to centralized Group Policy and WSUS allows security baselines to be enforced across thousands of endpoints instantaneously, ensuring a robust and predictable defense posture.

This project serves as a technical foundation for managing complex domain infrastructures and reflects the high-standard operational requirements found in enterprise-grade security environments.
