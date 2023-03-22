import pytest

from src.domain.model_address import Address


class TestAddress:
    def test_init(self):
        with pytest.raises(ValueError):
            a = Address(
                address_type="Random",
                preferred=True,
                number=10,
                street="Random",
                postal_code="Random",
                city="Random",
                state="Random"
            )