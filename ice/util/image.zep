namespace Ice\Util;

use Ice\Error;

/**
 * 图像处理
 * @author kelezyb
 */
class Image
{
    private _file;

    private _realpath;

    private _image;

    private _width;

    private _height;

    private _type;

    private _mime;

	public function __construct(string! file, int width = null, int height = null)
	{
        let this->_file = file;
        let this->_image = new \Imagick();

        if file_exists(this->_file) {
            let this->_realpath = realpath(this->_file);

            if !this->_image->readImage(this->_realpath) {
                 throw new Error("Imagick::readImage ".this->_file." failed");
            }
        } else {
            this->_image->newImage(width, height, new \ImagickPixel("transparent"));
            this->_image->setFormat("png");
            this->_image->setImageFormat("png");

            let this->_realpath = this->_file;
        }

        let this->_width = this->_image->getImageWidth();
        let this->_height = this->_image->getImageHeight();
        let this->_type = this->_image->getImageType();
        let this->_mime = "image/" . this->_image->getImageFormat();
	}
}