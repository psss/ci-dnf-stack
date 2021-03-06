Feature: check-update commands

Scenario: check for updates according to priority
Given I use repository "dnf-ci-fedora"
 When I execute dnf with args "install glibc"
 Then the exit code is 0
  And Transaction is following
      | Action        | Package                                   |
      | install       | basesystem-0:11-6.fc29.noarch             |
      | install       | filesystem-0:3.9-2.fc29.x86_64            |
      | install       | setup-0:2.12.1-1.fc29.noarch              |
      | install       | glibc-0:2.28-9.fc29.x86_64                |
      | install       | glibc-common-0:2.28-9.fc29.x86_64         |
      | install       | glibc-all-langpacks-0:2.28-9.fc29.x86_64  |
Given I use repository "dnf-ci-fedora-updates"
 When I execute dnf with args "check-update"
 Then the exit code is 100
 Then stdout contains "glibc.x86_64\s+2.28-26.fc29\s+dnf-ci-fedora-updates"
 Then stdout contains "glibc-common.x86_64\s+2.28-26.fc29\s+dnf-ci-fedora-updates"
 Then stdout contains "glibc-all-langpacks.x86_64\s+2.28-26.fc29\s+dnf-ci-fedora-updates"
Given I use repository "dnf-ci-fedora-updates" with configuration
      | key           | value   |
      | priority      | 100     |
 When I execute dnf with args "check-update"
 Then the exit code is 0
 When I execute dnf with args "upgrade"
 Then the exit code is 0
  And Transaction is empty
