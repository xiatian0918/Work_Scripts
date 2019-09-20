#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

from django import template
from django.utils.safestring import mark_safe

register = template.Library()

@register.simple_tag
def houyafan(a1,a2):
    return a1 + a2


@register.filter
def jiajingze(a1,a2):
    return a1 + a2