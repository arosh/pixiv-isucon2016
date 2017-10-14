import app
import os

def main():
    cursor = app.db().cursor()
    cursor.execute('SELECT `id` FROM `posts`')
    ids = [datum['id'] for datum in cursor.fetchall()]
    DIR = '../public/image'
    if not os.path.isdir(DIR):
        os.mkdir(DIR)
    for id in ids:
        print('id = %d' % id)
        cursor = app.db().cursor()
        cursor.execute('SELECT * FROM `posts` WHERE `id` = %s', (id,))
        post = cursor.fetchone()
        mime = post['mime']
        if mime == 'image/jpeg':
            ext = 'jpg'
        elif mime == 'image/png':
            ext = 'png'
        elif mime == 'image/gif':
            ext = 'gif'
        else:
            raise RuntimeError('mime = %s' % mime)
        filename = '%s/%d.%s' % (DIR, id, ext)
        with open(filename, 'wb') as f:
            f.write(post['imgdata'])

if __name__ == '__main__':
    main()
