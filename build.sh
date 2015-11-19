#!/bin/sh

zephir build

/etc/init.d/php-fpm reload
