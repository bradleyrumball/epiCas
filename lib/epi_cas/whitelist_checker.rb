module EpiCas
  class WhitelistChecker < Struct.new(:raw_dn, :uid, :ou, :user_class)
    USER_GROUPS = {
      'ou=staff,ou=users,dc=sheffield,dc=ac,dc=uk'                                 => :staff,
      'ou=retired,ou=users,dc=sheffield,dc=ac,dc=uk'                               => :staff_retired,
      'ou=honorary,ou=staff,ou=users,dc=sheffield,dc=ac,dc=uk'                     => :staff_honorary,
      'ou=visiting,ou=staff,ou=users,dc=sheffield,dc=ac,dc=uk'                     => :staff_visiting,
      'ou=external,ou=users,dc=sheffield,dc=ac,dc=uk'                              => :external,
      'ou=research,ou=postgraduates,ou=students,ou=users,dc=sheffield,dc=ac,dc=uk' => :student_pg_research,
      'ou=taught,ou=postgraduates,ou=students,ou=users,dc=sheffield,dc=ac,dc=uk'   => :student_pg_taught,
      'ou=undergraduates,ou=students,ou=users,dc=sheffield,dc=ac,dc=uk'            => :student_undergraduate,
      'ou=roles,ou=users,dc=sheffield,dc=ac,dc=uk'                                 => :role
    } 
  
    def allow_authentication?
      (username_whitelisted? || groups_allowed_to_log_in.member?(group)) && ou_whitelisted?
    end
  
    def allow_creation?
      (username_whitelisted? || groups_allowed_to_be_created.member?(group)) && ou_whitelisted?
    end
  
    private
      def groups_allowed_to_log_in
        @groups_allowed_to_log_in ||= settings('groups_allowed_to_log_in').to_a.map(&:to_sym)
      end
      
      def groups_allowed_to_be_created
        @groups_allowed_to_be_created ||= settings('groups_allowed_to_be_created').to_a.map(&:to_sym)
      end
      
      def username_whitelisted?
        (settings('username_whitelist') || []).member? uid.to_s.downcase
      end
      
      def ou_whitelisted?
        whitelist = (settings('department_code_whitelist') || [])
        return true if whitelist.blank?
        whitelist.include? ou
      end
      
      def group
        USER_GROUPS[dn]
      end
  
      def dn
        @dn ||= raw_dn[/ou=.*dc=uk/].to_s.downcase
      end
      
      def settings(setting_name, setting_class = EpiCas::Settings)
        class_specific_settings[setting_name] || setting_class[setting_name]
      end
      
      def class_specific_settings(setting_class = EpiCas::Settings)
        @class_specific_settings ||= ((setting_class['class_specific_settings'] || {})[user_class.to_s]) || {}
      end
  end
end