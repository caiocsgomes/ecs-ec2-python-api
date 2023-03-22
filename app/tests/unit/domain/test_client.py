import pytest

from src.domain.model_address import Address
from src.domain.model_client import Client


# TODO: Add test to assigning id ot user
# TODO: Add test to validate email

class TestClient:
    def test_init(self):
        with pytest.raises(ValueError):
            c = Client(
                name="Random",
                address=[
                    Address(
                        address_type="Random",
                        preferred=True,
                        number=1,
                        street="Random",
                        postal_code="Random",
                        city="Random",
                        state="Random"
                    ),
                    Address(
                        address_type="Random",
                        preferred=True,
                        number=2,
                        street="Random",
                        postal_code="Random",
                        city="Random",
                        state="Random"
                    )
                ],
                email="Random"
            )
