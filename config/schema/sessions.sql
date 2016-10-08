-- Copyright (c) Cake Software Foundation, Inc. (http://cakefoundation.org)
--
-- Licensed under The MIT License
-- For full copyright and license information, please see the LICENSE.txt
-- Redistributions of files must retain the above copyright notice.
-- MIT License (http://www.opensource.org/licenses/mit-license.php)

CREATE TABLE sessions (
  id CHAR(40) NOT NULL PRIMARY KEY,
  data TEXT,
  expires INTEGER NOT NULL
);
