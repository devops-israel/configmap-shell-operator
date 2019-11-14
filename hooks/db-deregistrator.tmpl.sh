#!/usr/bin/env bash
if [[ $1 == "--config" ]] ; then
  cat <<-EOF
	{
	  "configVersion":"v1",
	  "kubernetes": [
	    {
	      "apiVersion": "v1",
	      "kind": "Pod",
	      "watchEvent": ["Added","Modified","Deleted"]
	    }
	  ]
	}
	EOF
  exit 0
fi

echo "{{ $.Values.oracleDB.host }}"

jq -r '.[0] | { event: .watchEvent, podName: .object.metadata.name, nodeName: .object.spec.nodeName, phase: .object.status.phase }' "${BINDING_CONTEXT_PATH}"
