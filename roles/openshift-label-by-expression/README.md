# Apply a given label to OpenShift objects based on a name pattern

## Overview
This role allows you to apply a label to all objects (except Pods) which match a given expression. This is useful for applying
labels to items which all contain a certain string. This role will OVERWRITE ALL EXISTING LABELS for those objects.

## Example:
```yaml
---
- hosts: localhost

  roles:
    - role: openshift-label-by-expression
      vars:
        target_namespace: labs-ci-cd      ## Apply this to ONLY objects in the specified namespace
        name_pattern: ".*selenium.*"      ## Regex patterns are supported
        label: 'app=selenium'             ## The label to be applied
```