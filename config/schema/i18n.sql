-- Copyright (c) Cake Software Foundation, Inc. (http://cakefoundation.org)
--
-- Licensed under The MIT License
-- For full copyright and license information, please see the LICENSE.txt
-- Redistributions of files must retain the above copyright notice.
-- MIT License (http://www.opensource.org/licenses/mit-license.php)

CREATE TABLE i18n (
    id SERIAL NOT NULL PRIMARY KEY,
    locale VARCHAR(6) NOT NULL,
    model VARCHAR(255) NOT NULL,
    foreign_key INTEGER NOT NULL,
    field VARCHAR(255) NOT NULL,
    content TEXT
);

CREATE UNIQUE INDEX I18N_LOCALE_FIELD ON i18n (locale, model, foreign_key, field);
CREATE INDEX I18N_FIELD ON i18n (model, foreign_key, field);