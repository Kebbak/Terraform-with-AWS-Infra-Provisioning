import boto3
from botocore.exceptions import ClientError
import logging
from typing import Any, Dict, List, Optional

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)

class EC2InstanceWrapper:
    """Encapsulates Amazon Elastic Compute Cloud (Amazon EC2) instance actions using the client interface."""

    def __init__(
        self, ec2_client: Any, instances: Optional[List[Dict[str, Any]]] = None
    ) -> None:
        """
        Initializes the EC2InstanceWrapper with an EC2 client and optional instances.
        :param ec2_client: A Boto3 Amazon EC2 client. This client provides low-level access to AWS EC2 services.
        :param instances: A list of dictionaries representing Boto3 Instance objects.
        """
        self.ec2_client = ec2_client
        self.instances = instances or []

    @classmethod
    def from_client(cls) -> "EC2InstanceWrapper":
        """
        Creates an EC2InstanceWrapper instance with a default EC2 client.
        :return: An instance of EC2InstanceWrapper initialized with the default EC2 client.
        """
        ec2_client = boto3.client("ec2")
        return cls(ec2_client)

    def stop(self) -> Optional[Dict[str, Any]]:
        """
        Stops instances and waits for them to be in a stopped state.
        :return: The response to the stop request, or None if there are no instances to stop.
        """
        if not self.instances:
            logger.info("No instances to stop.")
            return None

        instance_ids = [instance["InstanceId"] for instance in self.instances]
        try:
            stop_response = self.ec2_client.stop_instances(InstanceIds=instance_ids)
            waiter = self.ec2_client.get_waiter("instance_stopped")
            waiter.wait(InstanceIds=instance_ids)
        except ClientError as err:
            logger.error(f"Failed to stop instance(s): {','.join(map(str, instance_ids))}")
            error_code = err.response["Error"]["Code"]
            if error_code == "IncorrectInstanceState":
                logger.error("Couldn't stop instance(s) because they are in an incorrect state. Ensure the instances are in a running state before stopping them.")
            raise
        return stop_response

# Example usage:
if __name__ == "__main__":
    # Replace with your instance ID(s)
    instance_ids = ["i-076dc0e2067181cc7"]
    instances = [{"InstanceId": iid} for iid in instance_ids]
    wrapper = EC2InstanceWrapper.from_client()
    wrapper.instances = instances
    response = wrapper.stop()
    print(response)
