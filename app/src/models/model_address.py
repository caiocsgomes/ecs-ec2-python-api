from dataclasses import dataclass, fields
from typing import Optional
from marshmallow import fields, post_load, Schema


@dataclass
class Address:
    street: str
    number: str
    city: str
    state: str
    country: str
    id: Optional[int] = None


class AddressSchema(Schema):
    id = fields.Int(required=False)
    street = fields.Str()
    number = fields.Int()
    city = fields.Str()
    state = fields.Str()
    country = fields.Str()

    @post_load
    def make_address(self, data, **kwargs):
        return Address(**data)
