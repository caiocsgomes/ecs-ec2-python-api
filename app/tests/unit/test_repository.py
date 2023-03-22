# import pytest
# from sqlalchemy.exc import NoResultFound
#
# from src.models.model_address import Address
#
#
# def test_get_by_id(address_repo):
#     address = Address(
#         street="passeio cuiaba",
#         number=2,
#         postal_code="15385-000",
#         city="Ilha Solteira",
#         state="SP",
#         address_type="Client",
#         preferred=True
#     )
#     address_repo.create(address)
#     addr = address_repo.get_by_id(address.id)
#     assert addr.street == "passeio cuiaba"
#
#
# def test_create(address_repo):
#     address = Address(
#         street="rua luiz moreira de lima",
#         number=2,
#         postal_code="11900-000",
#         city="Registro",
#         state="SP",
#         address_type="Client",
#         preferred=True
#     )
#
#     db_address = address_repo.create(address)
#     assert db_address.street == address.street
#     assert db_address.id is not None
#
#
# def test_update(address_repo):
#     address = Address(
#         street="rua luiz moreira de lima",
#         number=2,
#         postal_code="11900-000",
#         city="Registro",
#         state="SP",
#         address_type="Client",
#         preferred=True
#     )
#     db_address = address_repo.create(address)
#     assert db_address.street == address.street
#     db_address.street = "rua avanhandava"
#     updated_address = address_repo.update(db_address.id, db_address)
#     assert updated_address.street == "rua avanhandava"
#
#
# def test_delete(address_repo):
#     address = Address(
#         street="rua luiz moreira de lima",
#         number=2,
#         postal_code="11900-000",
#         city="Registro",
#         state="SP",
#         address_type="Client",
#         preferred=True
#     )
#     address_repo.create(address)
#     db_address = address_repo.get_by_id(address.id)
#     assert db_address is not None
#     address_repo.delete(db_address.id)
#     with pytest.raises(NoResultFound):
#         address_repo.get_by_id(db_address.id)
