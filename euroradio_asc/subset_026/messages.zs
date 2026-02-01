package euroradio_asc.subset_026.messages;

import euroradio_asc.subset_026.packages.*;


const uint8 ASCII_CODE_SENTENCE_START = 0x24; // ASCII for '$'
const uint8 ASCII_CODE_SENTENCE_END = 0x2A; // ASCII for '*'
const uint8 ASCII_CODE_COMMA = 0x2C; // ASCII for ','
const uint8 ASCII_CODE_DOT = 0x2E; // ASCII for '.'
const uint8 ASCII_CODE_N = 0x4E; // ASCII for 'N'
const uint8 ASCII_CODE_S = 0x53; // ASCII for 'S'
const uint8 ASCII_CODE_E = 0x45; // ASCII for 'E'
const uint8 ASCII_CODE_W = 0x57; // ASCII for 'W'
const uint8 ASCII_CODE_0 = 0x30; // ASCII for '0'
const uint8 ASCII_CODE_8 = 0x38; // ASCII for '8'
const uint8 ASCII_CODE_9 = 0x39; // ASCII for '9'
const uint8 ASCII_CODE_1 = 0x31; // ASCII for '1'
const uint8 ASCII_CODE_2 = 0x32; // ASCII for '2'
const uint8 ASCII_CODE_M = 0x4D; // ASCII for 'M'
const uint8 ASCII_CODE_G = 0x47; // ASCII for 'G'
const uint8 ASCII_CODE_A = 0x41; // ASCII for 'A'

const uint8 ASCII_CODE_MINUS = 0x2D; // ASCII for '-'

const uint8 ASCII_CODE_CR = 0x0D; // ASCII for '<CR>'
const uint8 ASCII_CODE_LF = 0x0A; // ASCII for '<LF>'

struct Sentence
{
    uint8 sentenceStart = ASCII_CODE_SENTENCE_START : sentenceStart == ASCII_CODE_SENTENCE_START;
    
    uint8 talkerIdFirstChar;
    uint8 talkerIdSecondChar;

    uint8 sentenceIdFirstChar;
    uint8 sentenceIdSecondChar;
    uint8 sentenceIdThirdChar;

    GGA gga if sentenceIdFirstChar == ASCII_CODE_G && sentenceIdSecondChar == ASCII_CODE_G && sentenceIdThirdChar == ASCII_CODE_A;

    uint8 sentenceEnd = ASCII_CODE_SENTENCE_END : sentenceEnd == ASCII_CODE_SENTENCE_END;

    uint8 checksumFirstChar;
    uint8 checksumSecondChar;

    uint8 cr = ASCII_CODE_CR : cr == ASCII_CODE_CR;
    uint8 lf = ASCII_CODE_LF : lf == ASCII_CODE_CR;
};


struct GGA {

    uint8 timeComma = ASCII_CODE_COMMA : timeComma == ASCII_CODE_COMMA;

    // Time (UTC) - hhmmss.sss format
    uint8 timeHoursTens;
    uint8 timeHoursOnes;
    uint8 timeMinutesTens;
    uint8 timeMinutesOnes;
    uint8 timeSecondsTens;
    uint8 timeSecondsOnes;
    uint8 timeDot = ASCII_CODE_DOT : timeDot == ASCII_CODE_DOT;
    uint8 timeSecondsDecimalTenths;
    uint8 timeSecondsDecimalHundredths;                      
    uint8 timeSecondsDecimalThousandths;
    
    uint8 latitudeComma = ASCII_CODE_COMMA : latitudeComma == ASCII_CODE_COMMA;

    // Latitude - GGMM.MMMMM format
    uint8 latitudeDegreesTens;
    uint8 latitudeDegreesOnes;
    uint8 latitudeMinutesTens;
    uint8 latitudeMinutesOnes;
    uint8 latitudeDot = ASCII_CODE_DOT : latitudeDot == ASCII_CODE_DOT;
    uint8 latitudeDecimalTenths;
    uint8 latitudeDecimalHundredths;
    uint8 latitudeDecimalThousandths;
    uint8 latitudeDecimalTenThousandths;
    uint8 latitudeDecimalHundredThousandths;
    
    uint8 latitudeDirectionComma = ASCII_CODE_COMMA : latitudeDirectionComma == ASCII_CODE_COMMA;

    // Latitude direction (N or S)
    uint8 latitudeDirection = ASCII_CODE_N : latitudeDirection == ASCII_CODE_N || latitudeDirection == ASCII_CODE_S;
    
    uint8 longitudeComma = ASCII_CODE_COMMA : longitudeComma == ASCII_CODE_COMMA;
    
    // Longitude - GGGMM.MMMMM format  
    uint8 longitudeDegreesHundreds;
    uint8 longitudeDegreesTens;
    uint8 longitudeDegreesOnes;
    uint8 longitudeMinutesTens;
    uint8 longitudeMinutesOnes;
    uint8 longitudeDot = ASCII_CODE_DOT : longitudeDot == ASCII_CODE_DOT;
    uint8 longitudeDecimalTenths;
    uint8 longitudeDecimalHundredths;
    uint8 longitudeDecimalThousandths;
    uint8 longitudeDecimalTenThousandths;
    uint8 longitudeDecimalHundredThousandths;
    
    uint8 longitudeDirectionComma = ASCII_CODE_COMMA : longitudeDirectionComma == ASCII_CODE_COMMA;
    
    // Longitude direction (E or W)
    uint8 longitudeDirection = ASCII_CODE_E : longitudeDirection == ASCII_CODE_E || longitudeDirection == ASCII_CODE_W;
    
    uint8 gpsQualityIndicatorComma = ASCII_CODE_COMMA : gpsQualityIndicatorComma == ASCII_CODE_COMMA;
    
    // GPS Quality Indicator (0-8)
    uint8 gpsQualityIndicator = ASCII_CODE_0 : gpsQualityIndicator >= ASCII_CODE_0 && gpsQualityIndicator <= ASCII_CODE_8;
    
    uint8 satellitesComma = ASCII_CODE_COMMA : satellitesComma == ASCII_CODE_COMMA;

    // Number of satellites (00-12) - two ASCII digits
    uint8 satellitesTens = ASCII_CODE_0 : satellitesTens >= ASCII_CODE_0 && satellitesTens <= ASCII_CODE_1;
    uint8 satellitesOnes : (satellitesTens == ASCII_CODE_0) ? (satellitesOnes >= ASCII_CODE_0 && satellitesOnes <= ASCII_CODE_9) : (satellitesOnes >= ASCII_CODE_0 && satellitesOnes <= ASCII_CODE_2);
    
    uint8 hdopComma = ASCII_CODE_COMMA : hdopComma == ASCII_CODE_COMMA;

    // Horizontal dilution of precision - x.x format
    uint8 hdopFirstChar;
    HDOPWithMinusSign hdopWithMinusSign if hdopFirstChar == ASCII_CODE_MINUS;
    HDOPWithoutMinusSign hdopWithoutMinusSign if hdopFirstChar >= ASCII_CODE_0 && hdopFirstChar <= ASCII_CODE_9;
    
    uint8 altitudeComma = ASCII_CODE_COMMA : altitudeComma == ASCII_CODE_COMMA;

    // Altitude above mean-sea-level - xxx.x format  
    uint8 altitudeFirstChar;
    AltitudeWithMinusSign altitudeWithMinusSign if altitudeFirstChar == ASCII_CODE_MINUS;
    AltitudeWithoutMinusSign altitudeWithoutMinusSign if altitudeFirstChar >= ASCII_CODE_0 && altitudeFirstChar <= ASCII_CODE_9;
    
    uint8 altitudeUnitsComma = ASCII_CODE_COMMA : altitudeUnitsComma == ASCII_CODE_COMMA;

    // Units of antenna altitude (always 'M')
    uint8 altitudeUnits = ASCII_CODE_M : altitudeUnits == ASCII_CODE_M;
    
    uint8 geoidSepComma = ASCII_CODE_COMMA : geoidSepComma == ASCII_CODE_COMMA;

    // Geoidal separation - xx.x format
    uint8 geoidSepFirstChar;
    GeoidSepWithMinusSign geoidSepWithMinusSign if geoidSepFirstChar == ASCII_CODE_MINUS;
    GeoidSepWithoutMinusSign geoidSepWithoutMinusSign if geoidSepFirstChar >= ASCII_CODE_0 && geoidSepFirstChar <= ASCII_CODE_9;
    
    uint8 geoidSepUnitsComma = ASCII_CODE_COMMA : geoidSepUnitsComma == ASCII_CODE_COMMA;

    // Units of geoidal separation (always 'M')
    uint8 geoidSepUnits = ASCII_CODE_M : geoidSepUnits == ASCII_CODE_M;
    
    uint8 dgpsAgeComma = ASCII_CODE_COMMA : dgpsAgeComma == ASCII_CODE_COMMA;

    // Age of differential GPS data
    uint8 dgpsAgeFirstChar;
    DgpsAgeWithMinusSign dgpsAgeWithMinusSign if dgpsAgeFirstChar == ASCII_CODE_MINUS;
    DgpsAgeWithoutMinusSign dgpsAgeWithoutMinusSign if dgpsAgeFirstChar >= ASCII_CODE_0 && dgpsAgeFirstChar <= ASCII_CODE_9;
    
    uint8 dgpsStationComma = ASCII_CODE_COMMA : dgpsStationComma == ASCII_CODE_COMMA;

    // DGPS reference station ID - 0000-1023
    uint8 dgpsStationFirstChar;
    uint8 dgpsStationSecondChar;
    uint8 dgpsStationThirdChar;
    uint8 dgpsStationFourthChar;

};


// HDOP structures (x.x format)
struct HDOPWithMinusSign {
    uint8 hdopWhole;                    // Only one whole digit after minus
    uint8 hdopDot = ASCII_CODE_DOT : hdopDot == ASCII_CODE_DOT;
    uint8 hdopDecimal;
};

struct HDOPWithoutMinusSign {
    uint8 hdopWhole;                    // First whole digit
    uint8 hdopDot = ASCII_CODE_DOT : hdopDot == ASCII_CODE_DOT;
    uint8 hdopDecimal;
};

// Altitude structures (xxx.x format)
struct AltitudeWithMinusSign {
    uint8 altitudeHundreds;             // First digit after minus
    uint8 altitudeTens;                 // Second digit
    uint8 altitudeOnes;                 // Third digit  
    uint8 altitudeDot = ASCII_CODE_DOT : altitudeDot == ASCII_CODE_DOT;
    uint8 altitudeDecimal;
};

struct AltitudeWithoutMinusSign {
    uint8 altitudeTens;                 // First digit (hundreds moved to GGA)
    uint8 altitudeOnes;                 // Second digit
    uint8 altitudeDot = ASCII_CODE_DOT : altitudeDot == ASCII_CODE_DOT;
    uint8 altitudeDecimal;
};

// Geoidal separation structures (xx.x format)  
struct GeoidSepWithMinusSign {
    uint8 geoidSepTens;                 // First digit after minus
    uint8 geoidSepOnes;                 // Second digit
    uint8 geoidSepDot = ASCII_CODE_DOT : geoidSepDot == ASCII_CODE_DOT;
    uint8 geoidSepDecimal;
};

struct GeoidSepWithoutMinusSign {
    uint8 geoidSepOnes;                 // First digit (tens moved to GGA)
    uint8 geoidSepDot = ASCII_CODE_DOT : geoidSepDot == ASCII_CODE_DOT;
    uint8 geoidSepDecimal;
};

// DGPS Age structures (xxx.xx format - always positive in practice)
struct DgpsAgeWithMinusSign {
    uint8 dgpsAgeFirstChar;             // First digit after minus
    uint8 dgpsAgeSecondChar;            // Second digit
    uint8 dgpsAgeThirdChar;             // Third digit
    uint8 dgpsAgeDot = ASCII_CODE_DOT : dgpsAgeDot == ASCII_CODE_DOT;
    uint8 dgpsAgeFourthChar;            // Fourth digit
    uint8 dgpsAgeFifthChar;             // Fifth digit
};

struct DgpsAgeWithoutMinusSign {
    uint8 dgpsAgeSecondChar;            // First digit (first char in GGA)
    uint8 dgpsAgeThirdChar;             // Second digit
    uint8 dgpsAgeDot = ASCII_CODE_DOT : dgpsAgeDot == ASCII_CODE_DOT;
    uint8 dgpsAgeFourthChar;            // Third digit
    uint8 dgpsAgeFifthChar;             // Fourth digit
};
