SELECT RTRIM('Hello.....', '.');
-- Output: 'Hello'

SELECT LTRIM('aaHello', 'a');
-- Output: 'Hello'

SELECT BTRIM('-Hello, World!-', '-');
-- Output: 'Hello, World!'

SELECT TRIM('   Hello, World!  ');
-- Output: 'Hello, World!'