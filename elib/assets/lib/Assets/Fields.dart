import 'dart:io' show Platform;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Fields {
  //  static final String Server = "192.168.198.254";
  static final String Server = "localhost";

  // static final List<List<String>> college = [
  //   [
  //     'College of Agriculture, Food & Sustainable Development',
  //     'lib/Assets/CAFSD.png'
  //   ],
  //   ['College of Aquatic Sciences, Applied Technology', 'lib/Assets/CASAT.png'],
  //   ['College of Arts and Sciences', 'lib/Assets/CAS.png'],
  //   ['College of Business Economics & Accountancy', 'lib/Assets/CBEA.png'],
  //   ['College of Computing & Information Sciences', 'lib/Assets/CCIS.png'],
  //   ['College of Engineering', 'lib/Assets/COE.png'],
  //   ['College of Health Sciences', 'lib/Assets/CHS.png'],
  //   ['College of Industrial Technology', 'lib/Assets/CIT.png'],
  //   ['College of Teacher Education', 'lib/Assets/CTE.png'],
  //   ['College of Medicine', 'lib/Assets/COM.png'],
  //   ['College of Law', 'lib/Assets/COL.png'],
  //   ['College of Veterinary Medicine', 'lib/Assets/CVM.png'],
  //   ['Graduate School', 'lib/Assets/GS.png'],
  // ];

  static final List<Map<String, dynamic>> college = [
    {
      'id': 1,
      'college': 'College of Agriculture, Food & Sustainable Development',
      'collegeShort':'CAFSD',
      'logo': 'lib/Assets/CAFSD.png',
      'overviewText':
          'The College of Agriculture, Food & Sustainable Development (CAFSD) is dedicated to advancing the fields of agriculture and food science while promoting sustainable development practices. The college offers a variety of programs focused on crop production, animal husbandry, agricultural engineering, food technology, and environmental management. CAFSD is committed to equipping students with the knowledge and skills needed to address the challenges of food security, environmental sustainability, and rural development. Through research, innovation, and community engagement, the college plays a pivotal role in the agricultural and economic development of the region.',
      'departments': [
        'Environmental Science',
        'Agricultural Sciences',
        'Development Communication',
        'Forestry',
        'Food Technology',
        'Agribussiness'
      ]
    },
    {
      'id': 2,
      'college': 'College of Aquatic Sciences, Applied Technology',
            'collegeShort':'CASAT',
      'logo': 'lib/Assets/CASAT.png',
      'overviewText':
          'The College of Aquatic Sciences and Applied Technology (CASAT) specializes in programs related to marine and aquatic sciences, as well as applied technology. CASAT is committed to sustainable development and the conservation of aquatic resources. The college provides students with the knowledge and skills needed to address environmental challenges and contribute to the sustainable use of aquatic ecosystems.',
      'departments': ['Fisheries', 'Marine Biology', 'General Education']
    },
    {
      'id': 3,
      'college': 'College of Arts and Sciences',
            'collegeShort':'CAS',
      'logo': 'lib/Assets/CAS.png',
      'overviewText':
          'The College of Arts and Sciences (CAS) is the intellectual hub of MMSU, offering diverse programs in both the social and natural sciences. It nurtures critical thinking, creativity, and a passion for knowledge, preparing students for various careers in research, teaching, and public service. CAS is dedicated to fostering a deep understanding of the world through interdisciplinary approaches and rigorous academic training.',
      'departments': [
        'Languages & Literature',
        'Physical Sciences',
        'Mathematics',
        'Biology',
        'Physical Education',
        'Social Sciences'
      ]
    },
    {
      'id': 4,
      'college': 'College of Business Economics & Accountancy',
            'collegeShort':'CBEA',
      'logo': 'lib/Assets/CBEA.png',
      'overviewText':
          'The College of Business, Economics, and Accountancy (CBEA) is committed to producing future business leaders and innovators. With programs that span business administration, economics, and accountancy, CBEA equips students with the analytical and managerial skills necessary to excel in the global marketplace. The college emphasizes ethical business practices, entrepreneurship, and leadership development.',
      'departments': [
        'Accountancy',
        'Business Administration',
        'Economics',
        'Tourism & Hospitality',
        'Management'
      ]
    },
    {
      'id': 5,
      'college': 'College of Computing & Information Sciences',
            'collegeShort':'CCIS',
      'logo': 'lib/Assets/CCIS.png',
      'overviewText':
          'The College of Information and Computing Sciences (CICS) is at the forefront of technology education at MMSU. Offering programs in computer science, information technology, and related fields, CICS prepares students for careers in the fast-paced world of technology. The college emphasizes innovation, problem-solving, and the application of computing skills to real-world challenges.',
      'departments': ['Computer Science', 'Information Technology']
    },
    {
      'id': 6,
      'college': 'College of Engineering',
            'collegeShort':'COE',
      'logo': 'lib/Assets/COE.png',
      'overviewText':
          'The College of Engineering (COE) at MMSU is a leader in engineering education, offering specialized programs in civil, electrical, mechanical, and other engineering disciplines. COE is dedicated to developing problem-solvers and innovators who can contribute to the advancement of technology and infrastructure. Students are trained in both theoretical knowledge and practical applications, preparing them for successful careers in engineering.',
      'departments': [
        'Electronics Engineering(ECE)',
        'Mechanical Engineering(ME)',
        'Civil Engineering(CE)',
        'Computer Engineering(CPE)',
        'Chemical Engineering(ChemE)',
        'Ceramics Engineering(CerE)',
        'Electrical Engineering(EE)',
        'Agriculture and Biosystems Engineering(ABE)'
      ]
    },
    {
      'id': 7,
      'college': 'College of Health Sciences',
            'collegeShort':'CHS',
      'logo': 'lib/Assets/CHS.png',
      'overviewText':
          'The College of Health Sciences (CHS) focuses on the education and training of health professionals who are equipped to meet the challenges of the healthcare industry. Offering programs in nursing, pharmacy, and public health, CHS is committed to improving health outcomes through education, research, and community engagement. The college emphasizes compassion, excellence, and leadership in healthcare.',
      'departments': ['Nursing', 'Physical Therapy', 'Pharmacy']
    },
    {
      'id': 8,
      'college': 'College of Industrial Technology',
            'collegeShort':'CIT',
      'logo': 'lib/Assets/CIT.png',
      'overviewText':
          'The College of Industrial Technology (CIT) provides education and training in various technical and vocational fields. CIT is dedicated to producing highly skilled technicians and technologists who can meet the demands of industry and contribute to national development. The college offers hands-on training and industry-relevant curricula, ensuring that graduates are job-ready and proficient in their chosen fields.',
      'departments': ['Industrial Technology', 'Automotive Technology']
    },
    {
      'id': 9,
      'college': 'College of Teacher Education',
            'collegeShort':'CTE',
      'logo': 'lib/Assets/CTE.png',
      'overviewText':
          'The College of Teacher Education (CTE) is dedicated to the preparation of future educators who are committed to excellence in teaching and learning. CTE offers programs that cover various levels of education, from early childhood to secondary education. The college focuses on developing educators who are knowledgeable, compassionate, and capable of inspiring students to achieve their full potential.',
      'departments': [
        'Elementary Education',
        'Secondary Education',
        'Early Childhood & Special Needs Education',
        'Human Movement & Arts Education',
        'Technical Vocational & Livelihood Education'
      ]
    },
    {
      'id': 10,
      'college': 'College of Medicine',
            'collegeShort':'COM',
      'logo': 'lib/Assets/COM.png',
      'overviewText':
          'The College of Medicine (COM) at MMSU is dedicated to training compassionate and skilled physicians who are committed to improving healthcare in the community and beyond. The college offers a rigorous medical program that combines basic sciences with clinical training, ensuring that graduates are well-prepared to meet the challenges of modern healthcare. COM emphasizes holistic care, medical ethics, and continuous learning in the rapidly evolving field of medicine.',
      'departments': ['Medicine']
    },
    {
      'id': 11,
      'college': 'College of Law',
            'collegeShort':'COL',
      'logo': 'lib/Assets/COL.png',
      'overviewText':
          'The College of Law (COL) provides a comprehensive legal education that prepares students for successful careers in the legal profession. The college offers a curriculum that covers all major areas of law, including constitutional law, criminal law, and civil law. COL is committed to developing lawyers who are not only knowledgeable and skilled but also ethical and dedicated to justice. The college fosters critical thinking, effective communication, and a deep understanding of legal principles.',
      'departments': ['Laws']
    },
    {
      'id': 12,
      'college': 'College of Veterinary Medicine',
            'collegeShort':'CVM',
      'overviewText':
          'The College of Veterinary Medicine (CVM) is focused on the education and training of future veterinarians who are passionate about animal health and welfare. The college offers a curriculum that covers a wide range of veterinary sciences, from animal physiology to disease prevention and treatment. CVM emphasizes hands-on experience, research, and community service, preparing graduates to contribute to the well-being of animals and public health.',
      'logo': 'lib/Assets/CVM.png',
      'departments': ['Veterinary Medicine']
    },
    {
      'id': 13,
      'college': 'Graduate School',
            'collegeShort':'GS',
      'logo': 'lib/Assets/GS.png',
      'overviewText':
          'The Graduate School (GS) at MMSU offers advanced degree programs designed to deepen knowledge and enhance expertise in various fields. GS provides a stimulating academic environment where students can engage in research, critical analysis, and professional development. The school offers master\'s and doctoral programs across a wide range of disciplines, fostering leadership, innovation, and academic excellence. The Graduate School is committed to producing scholars and professionals who can contribute meaningfully to society and their respective fields.',
      'departments': ['Graduate School']
    },
  ];

  static final String MMSU = 'lib/Assets/mmsu_logo.png';

  // static final String Server = "127.0.0.1";
}
class Config {

  //  static final String Server = "172.20.10.2";
  static final String Server = "localhost";

  
  
}