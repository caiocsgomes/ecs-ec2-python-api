import pytest
from sqlalchemy.exc import NoResultFound

from src.domain.model_address import Address
from src.service.crud_service import CrudService
from src.service.unit_of_work import AbstractUnitOfWork, SqlAlchemyUnitOfWork


class TestAddressService:
    uow: AbstractUnitOfWork

    @staticmethod
    def setup_class(cls):
        cls.uow = SqlAlchemyUnitOfWork[Address](Address)
        cls.service = CrudService[Address](cls.uow)

    def test_create(self):
        address = Address(
            street="test street",
            number=1,
            postal_code="12345",
            city="Dublin",
            state="LM",
            address_type="client",
            preferred=True
        )
        address_id = self.service.create(address)
        assert address_id is not None

    def test_get(self):
        address = Address(
            street="test street",
            number=1,
            postal_code="12345",
            city="Dublin",
            state="LM",
            address_type="client",
            preferred=True
        )
        address_id = self.service.create(address)
        address_from_db = self.service.get(address_id)
        assert address.street == address_from_db.street

    def test_delete(self):
        address = Address(
            street="test street",
            number=1,
            postal_code="12345",
            city="Dublin",
            state="LM",
            address_type="client",
            preferred=True
        )
        address_id = self.service.create(address)
        self.service.delete(address_id)
        with pytest.raises(NoResultFound):
            self.service.get(address_id)

    def test_update(self):
        address = Address(
            street="test street",
            number=1,
            postal_code="12345",
            city="Dublin",
            state="LM",
            address_type="client",
            preferred=True
        )
        address_id = self.service.create(address)
        address.city = "London"
        self.service.update(address_id, address)
        assert self.service.get(address_id).city == "London"
