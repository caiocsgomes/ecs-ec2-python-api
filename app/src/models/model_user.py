from dataclasses import dataclass
from typing import Optional
from marshmallow import fields, post_load, Schema

from models.model_address import Address, AddressSchema


@dataclass
class User:
    name: str
    email: str
    address: list[Address]
    id: Optional[int] = None


class UserSchema(Schema):
    id = fields.Int(required=False)
    name = fields.Str()
    email = fields.Str()
    address = fields.List(fields.Nested(AddressSchema))

    @post_load
    def make_user(self, data, **kwargs):
        return User(**data)
